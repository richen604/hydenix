{ hydenix-inputs }:

let
  system = "x86_64-linux";
  pkgs = import hydenix-inputs.hydenix-nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    commitlint
    direnv
    nix-direnv
  ];

  shellHook = ''
    export USE_DIRENV=1

    # Set up git hooks directory
    git config core.hooksPath .git-hooks

    # Ensure .git-hooks directory exists
    mkdir -p .git-hooks

    # Create commit-msg hook
    cat > .git-hooks/commit-msg <<'EOF'
    #!/usr/bin/env sh
    ${pkgs.commitlint}/bin/commitlint --edit "$1"
    EOF

    # Create pre-push hook
    cat > .git-hooks/pre-push <<'EOF'
    #!/usr/bin/env sh
    echo "Running pre-push checks..."

    echo "Running nix flake check..."
    nix flake check
    if [ $? -ne 0 ]; then
      echo "Error: nix flake check failed"
      exit 1
    fi

    echo "Running template flake check..."
    cd template
    sed -i 's|url = "github:richen604/hydenix"|url = "path:../"|' flake.nix
    nix flake check
    if [ $? -ne 0 ]; then
      echo "Error: template flake check failed"
      git checkout flake.nix
      rm -f flake.lock
      exit 1
    fi
    git checkout flake.nix
    rm -f flake.lock
    git rm flake.lock
    cd ..
    EOF

    # Make hooks executable
    chmod +x .git-hooks/commit-msg
    chmod +x .git-hooks/pre-push
  '';
}
