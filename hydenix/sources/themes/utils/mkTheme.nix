{ pkgs }:
{
  name,
  src,
  meta,
  arcs,
}:
let
  # Process arc configurations
  gtkName = arcs.gtk or null;
  iconName = arcs.icon or null;
  cursorName = arcs.cursor or null;
  fontName = arcs.font or null;

  # Combined theme package that includes all arcs
  pkg = pkgs.stdenv.mkDerivation {
    inherit name src;
    pname = name;

    version = "1.0.0";

    nativeBuildInputs = with pkgs; [
      jdupes
      gnutar
    ];

    dontConfigure = true;
    dontBuild = true;
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

      cp -r Configs/.config/hyde/themes/"${name}"/. $out/share/hyde/themes/"${name}"/

      # Install GTK theme if available
      ${
        if gtkName != null then
          ''
            echo "Installing GTK theme: ${gtkName}"
            mkdir -p $out/share/themes

            # Find and extract the GTK theme archive
            for gtk_archive in ./Source/Gtk_*.tar*; do
              if [ -f "$gtk_archive" ]; then
                echo "Extracting GTK theme: ''${gtk_archive}"
                tar -xf "$gtk_archive" -C $out/share/themes
                break
              fi
            done
          ''
        else
          ""
      }

      # Install icon theme if available
      ${
        if iconName != null then
          ''
            echo "Installing icon theme: ${iconName}"
            mkdir -p $out/share/icons/"${iconName}"

            # Find and extract the icon theme archive
            for icon_archive in ./Source/Icon_*.tar*; do
              if [ -f "$icon_archive" ]; then
                tar -xf "$icon_archive" --strip-components=1 --skip-old-files -C $out/share/icons/"${iconName}"
                
                # Fix broken symlinks by removing them
                find $out/share/icons/"${iconName}" -type l -exec sh -c 'test -e "$0" || rm "$0"' {} \;
                
                jdupes --recurse $out/share/icons/"${iconName}"
                break
              fi
            done
          ''
        else
          ""
      }

      # Install cursor theme if available
      ${
        if cursorName != null then
          ''
            echo "Installing cursor theme: ${cursorName}"
            mkdir -p $out/share/icons/"${cursorName}"

            # Find and extract the cursor theme archive
            for cursor_archive in ./Source/Cursor_*.tar*; do
              if [ -f "$cursor_archive" ]; then
                tar -xf "$cursor_archive" -C $out/share/icons/"${cursorName}"
                
                # Fix broken symlinks by removing them
                find $out/share/icons/"${cursorName}" -type l -exec sh -c 'test -e "$0" || rm "$0"' {} \;
                
                jdupes --recurse $out/share/icons/"${cursorName}"
                break
              fi
            done
          ''
        else
          ""
      }

      # Install font if available
      ${
        if fontName != null then
          ''
            echo "Installing font: ${fontName}"
            mkdir -p $out/share/fonts/"${fontName}"

            # Find and extract the font archive
            for font_archive in Source/Font_*.tar*; do
              if [ -f "$font_archive" ]; then
                tar -xf "$font_archive" -C $out/share/fonts/"${fontName}"
                break
              fi
            done
          ''
        else
          ""
      }
      runHook postInstall
    '';

    # Use theme priority to handle conflicts
    meta = with pkgs.lib; {
      inherit (meta) description homepage priority;
      license = licenses.mit;
      platforms = platforms.all;
    };
  };

in
pkg
