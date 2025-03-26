{ pkgs }:
{
  name,
  src,
  meta,
}:
let

  # Helper function to find the first directory in a path
  findFirstDir = ''
    findFirstDir() {
      local path="$1"
      if [ -d "$path" ]; then
        local first_dir=$(find "$path" -mindepth 1 -maxdepth 1 -type d | head -n 1)
        if [ -n "$first_dir" ]; then
          basename "$first_dir"
        else
          echo ""
        fi
      else
        echo ""
      fi
    }
  '';

  # Combined theme package that includes all arcs
  pkg = pkgs.stdenv.mkDerivation {
    inherit name src;
    pname = name;

    version = "1.0.0";

    nativeBuildInputs = with pkgs; [
      gnutar
    ];

    dontPatchELF = true;
    dontRewriteSymlinks = true;
    dontDropIconThemeCache = true;

    installPhase = ''
      runHook preInstall

      # Create theme directory structure
      mkdir -p $out/share/hyde/themes/"${name}"
      mkdir -p $out/share/themes
      mkdir -p $out/share/icons
      mkdir -p $out/share/fonts

      ${findFirstDir}

      cp -r Configs/.config/hyde/themes/"${name}"/. $out/share/hyde/themes/"${name}"/

      # Install GTK theme if available
      for gtk_archive in ./Source/arcs/Gtk_* ./Source/Gtk_*; do
        if [ -f "$gtk_archive" ]; then
          echo "Installing GTK theme from: $gtk_archive"
          tar -xf "$gtk_archive" -C $out/share/themes
          break
        fi
      done

      # Install icon theme if available
      for icon_archive in ./Source/arcs/Icon_* ./Source/Icon_*; do
        if [ -f "$icon_archive" ]; then
          echo "Installing icon theme from: $icon_archive"
          tar -xf "$icon_archive" --skip-old-files -C $out/share/icons
          
          ICON_DIR=$(findFirstDir $out/share/icons)
          echo "Icon directory: $ICON_DIR"
          
          # Only process broken symlinks if the icon directory exists
          if [ -n "$ICON_DIR" ] && [ -d "$out/share/icons/$ICON_DIR" ]; then
            # Fix broken symlinks in icon theme - limit to a reasonable depth
            find "$out/share/icons/$ICON_DIR" -maxdepth 5 -type l | while read -r link; do
              target=$(readlink "$link")
              if [[ "$target" == /* ]]; then
                # Skip absolute links
                continue
              fi
              
              target_path="$(dirname "$link")/$target"
              if [ ! -e "$target_path" ]; then
                rm "$link"
              fi
            done
          fi
          break
        fi
      done

      # Install cursor theme if available
      for cursor_archive in ./Source/arcs/Cursor_* ./Source/Cursor_*; do
        if [ -f "$cursor_archive" ]; then
          echo "Installing cursor theme from: $cursor_archive"
          tar -xf "$cursor_archive" --skip-old-files -C $out/share/icons
          break
        fi
      done

      # Install font if available
      for font_archive in ./Source/arcs/Font_* ./Source/Font_*; do
        if [ -f "$font_archive" ]; then
          echo "Installing font from: $font_archive"
          mkdir -p $out/share/fonts
          tar -xf "$font_archive" -C $out/share/fonts || echo "Warning: Failed to extract font archive $font_archive. Skipping."
          break
        fi
      done

      runHook postInstall
    '';

    # Add allowBrokenSymlinks to prevent build failures due to broken symlinks
    meta = with pkgs.lib; {
      inherit (meta) description homepage priority;
      license = licenses.mit;
      platforms = platforms.all;
    };
  };

in
pkg
