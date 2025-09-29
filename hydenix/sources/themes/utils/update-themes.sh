#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nix-prefetch-git gnused git

set -eo pipefail

THEMES_DIR="hydenix/sources/themes"

# Find all .nix files in the themes directory, excluding default.nix and files in utils/
find "$THEMES_DIR" -name "*.nix" ! -name "default.nix" ! -path "*/utils/*" | while read -r NIX_FILE; do
  echo "Processing $NIX_FILE..."

  # Extract owner, repo, current rev, and current sha256 from the .nix file
  OWNER=$(grep -oP 'owner = "\K[^"]+' "$NIX_FILE" || true)
  REPO=$(grep -oP 'repo = "\K[^"]+' "$NIX_FILE" || true)
  CURRENT_REV=$(grep -oP 'rev = "\K[^"]+' "$NIX_FILE" || true)
  CURRENT_SHA256=$(grep -oP 'sha256 = "\K[^"]+' "$NIX_FILE" || true)
  NAME=$(basename "$NIX_FILE" .nix) # Get theme name from filename

  if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$CURRENT_REV" ]; then
    echo "Warning: Could not extract owner, repo, or rev from $NIX_FILE. Skipping."
    continue
  fi

  echo "  Owner: $OWNER, Repo: $REPO, Current Rev: $CURRENT_REV"

  # Determine latest commit hash for the current branch/ref
  LATEST_COMMIT_HASH=""
  if [[ "$CURRENT_REV" =~ ^[0-9a-f]{40}$ ]]; then
    # CURRENT_REV is already a commit hash
    LATEST_COMMIT_HASH="$CURRENT_REV"
    echo "  Rev is already a commit hash: $CURRENT_REV"
  else
    # CURRENT_REV is likely a branch name, fetch the latest commit hash for it
    echo "  Rev is a branch name: $CURRENT_REV. Fetching latest commit hash..."
    REMOTE_URL="https://github.com/$OWNER/$REPO"
    LATEST_COMMIT_HASH=$(git ls-remote "$REMOTE_URL" "refs/heads/$CURRENT_REV" | awk '{print $1}')
    if [ -z "$LATEST_COMMIT_HASH" ]; then
        echo "Error: Could not fetch latest commit hash for $REMOTE_URL/$CURRENT_REV. Skipping."
        continue
    fi
    echo "  Latest commit hash for $CURRENT_REV: $LATEST_COMMIT_HASH"
  fi

  # Check if the current REV in the nix file is already the latest commit hash
  if [ "$CURRENT_REV" = "$LATEST_COMMIT_HASH" ] && [ -n "$CURRENT_SHA256" ]; then
    echo "  Theme $NAME is already at the latest commit ($CURRENT_REV). Checking SHA256 only."
    # If the rev is already the latest, let's still verify the sha256
    # Construct the URL for nix-prefetch-url using the LATEST_COMMIT_HASH
    FETCH_URL="https://github.com/$OWNER/$REPO/archive/$LATEST_COMMIT_HASH.tar.gz"
    VERIFIED_SHA256=$(nix-prefetch-url --unpack "$FETCH_URL")
    VERIFIED_SHA256=$(nix hash to-sri --type sha256 "$VERIFIED_SHA256")

    if [ "$CURRENT_SHA256" == "$VERIFIED_SHA256" ]; then
      echo "  Theme $NAME (rev: $LATEST_COMMIT_HASH) is already up to date. Skipping."
    else
      echo "  Updating $NAME: sha256 $CURRENT_SHA256 -> $VERIFIED_SHA256 (rev unchanged: $LATEST_COMMIT_HASH)"
      sed -i -E "s|^([[:space:]]*)sha256 = .*$|\1sha256 = \"$VERIFIED_SHA256\";|" "$NIX_FILE"
      echo "  Updated $NIX_FILE"
    fi
  else
    echo "  Theme $NAME needs update (rev changed from $CURRENT_REV to $LATEST_COMMIT_HASH or initial update)."
    # Construct the URL for nix-prefetch-url using the LATEST_COMMIT_HASH
    FETCH_URL="https://github.com/$OWNER/$REPO/archive/$LATEST_COMMIT_HASH.tar.gz"

    NEW_SHA256=$(nix-prefetch-url --unpack "$FETCH_URL")
    # Convert to SRI format (sha256-<base64_hash>)
    NEW_SHA256=$(nix hash to-sri --type sha256 "$NEW_SHA256")

    if [ -z "$NEW_SHA256" ]; then
      echo "Error: Could not prefetch URL for $NAME ($FETCH_URL). Skipping."
      continue
    fi

    echo "  Updating $NAME: rev $CURRENT_REV -> $LATEST_COMMIT_HASH, sha256 $CURRENT_SHA256 -> $NEW_SHA256"
    # Update both the rev and sha256 lines
    sed -i -E "s|^([[:space:]]*)rev = .*$|\1rev = \"$LATEST_COMMIT_HASH\";|" "$NIX_FILE"
    sed -i -E "s|^([[:space:]]*)sha256 = .*$|\1sha256 = \"$NEW_SHA256\";|" "$NIX_FILE"
    echo "  Updated $NIX_FILE"
  fi
done

echo "Theme update process completed."
