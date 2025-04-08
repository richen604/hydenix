{ pkgs, commit }:
pkgs.stdenv.mkDerivation {
  name = "hyde-modified";
  src = pkgs.fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "HyDE";
    rev = commit;
    sha256 = "sha256-iD4DPfXb2Hkk2CqqRe9kB22WZQEEFafjCelbI7xRkiQ=";
  };

  nativeBuildInputs = with pkgs; [
    gnutar
  ];

  buildPhase = ''
    # remove assets folder
    rm -rf Source/assets

    # Update waybar killall command in all HyDE files
    find . -type f -print0 | xargs -0 sed -i 's/killall waybar/killall .waybar-wrapped/g'

    # update dunst
    find . -type f -print0 | xargs -0 sed -i 's/killall dunst/killall .dunst-wrapped/g'

    # update kitty
    find . -type f -print0 | xargs -0 sed -i 's/killall kitty/killall .kitty-wrapped/g'
    find . -type f -print0 | xargs -0 sed -i 's/killall -SIGUSR1 kitty/killall -SIGUSR1 .kitty-wrapped/g'

    # fix find commands for symlinks
    find . -type f -executable -print0 | xargs -0 sed -i 's/find "/find -L "/g'
    find . -type f -name "*.sh" -print0 | xargs -0 sed -i 's/find "/find -L "/g'

    # Extract font archives
    mkdir -p $out/share/fonts/truetype
    for fontarchive in ./Source/arcs/Font_*.tar.gz; do
      if [ -f "$fontarchive" ]; then
        tar xzf "$fontarchive" -C $out/share/fonts/truetype/
      fi
    done
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out
  '';
}
