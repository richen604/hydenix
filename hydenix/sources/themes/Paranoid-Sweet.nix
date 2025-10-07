{ pkgs, mkTheme }:
mkTheme rec {
  name = "Paranoid Sweet";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Paranoid-Sweet";
    rev = "303ec22d4d1276a636466f61eb71be28a1ef2a85";
    name = name;
    sha256 = "sha256-j4fjX2fWSBajNKFSovVsy+FydUcq5FEtk6B9iiDURAs=";
  };
  meta = {
    description = "HyDE Theme: Paranoid Sweet";
    homepage = "https://github.com/rishav12s/Paranoid-Sweet";
  };
}
