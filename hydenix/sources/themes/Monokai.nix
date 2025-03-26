{ pkgs, mkTheme }:
mkTheme rec {
  name = "Monokai";
  src = pkgs.fetchFromGitHub {
    owner = "mahaveergurjar";
    repo = "Theme-Gallery";
    rev = "2c4ecf9e32753da36832d2aa9f32908a92caab15";
    name = name;
    sha256 = "sha256-vxIm5Gasnv8xooGnFNFVmZJd7o2YkOORJD2pIQFZrhA=";
  };
  meta = {
    description = "HyDE Theme: Monokai";
    homepage = "https://github.com/mahaveergurjar/Theme-Gallery/tree/Monokai";
    priority = 10;
  };
}
