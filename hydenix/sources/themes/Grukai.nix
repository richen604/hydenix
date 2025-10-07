{ pkgs, mkTheme }:
mkTheme rec {
  name = "Grukai";
  src = pkgs.fetchFromGitHub {
    owner = "amit-0i";
    repo = "Grukai";
    rev = "95e0b92633b3622685cb29662d5e320f21753001";
    name = name;
    sha256 = "sha256-N8AErlZCypJSy+P1uO1iYYcdRmpGbiZ1TNhtJvo14Lg=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Grukai";
    homepage = "https://github.com/amit-0i/Grukai";
  };
}
