#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nix-prefetch-git gnused

set -eo pipefail

THEMES_DIR="hydenix/sources/themes"

# Find all .nix files in the themes directory, excluding default.nix and files in utils/
find "$THEMES_DIR" -name "*.nix" ! -name "default.nix" ! -path "*/utils/*" | while read -r NIX_FILE; do
  echo "Processing $NIX_FILE..."

  # Extract owner, repo, rev, and current sha256 from the .nix file
  OWNER=$(grep -oP 'owner = "\K[^"]+' "$NIX_FILE" || true)
  REPO=$(grep -oP 'repo = "\K[^"]+' "$NIX_FILE" || true)
  REV=$(grep -oP 'rev = "\K[^"]+' "$NIX_FILE" || true)
  CURRENT_SHA256=$(grep -oP 'sha256 = "\K[^"]+' "$NIX_FILE" || true)
  NAME=$(basename "$NIX_FILE" .nix) # Get theme name from filename

  if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$REV" ]; then
    echo "Warning: Could not extract owner, repo, or rev from $NIX_FILE. Skipping."
    continue
  fi

  echo "  Owner: $OWNER, Repo: $REPO, Rev: $REV"

  # Construct the URL for nix-prefetch-url
  FETCH_URL="https://github.com/$OWNER/$REPO/archive/$REV.tar.gz"

  NEW_SHA256=$(nix-prefetch-url --unpack "$FETCH_URL")
  # Convert to SRI format (sha256-<base64_hash>)
  NEW_SHA256=$(nix hash to-sri --type sha256 "$NEW_SHA256")

  if [ -z "$NEW_SHA256" ]; then
    echo "Error: Could not prefetch URL for $NAME ($FETCH_URL). Skipping."
    continue
  fi

  if [ "$CURRENT_SHA256" == "$NEW_SHA256" ]; then
    echo "  Theme $NAME is already up to date. Skipping."
  else
    echo "  Updating $NAME: sha256 $CURRENT_SHA256 -> $NEW_SHA256"
    # Update only the sha256 line
    sed -i -E "s|^([[:space:]]*)sha256 = .*$|\1sha256 = \"$NEW_SHA256\";|" "$NIX_FILE"
    echo "  Updated $NIX_FILE"
  fi
done

echo "Theme update process completed."
