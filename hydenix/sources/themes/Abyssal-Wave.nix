{ pkgs, mkTheme }:
mkTheme rec {
  name = "Abyssal-Wave";
  src = pkgs.fetchFromGitHub {
    owner = "Itz-Abhishek-Tiwari";
    repo = "Abyssal-Wave";
    # locking commit
    rev = "3094b030739c7673255a2a8fad1707717d725d73";
    name = name;
    sha256 = "sha256-JMYjNV2r6/lRwKNQFdz2HmZH7ZxLO0MdiO2iUi5R7As=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Abyssal-Wave";
    homepage = "https://github.com/Itz-Abhishek-Tiwari/Abyssal-Wave";
  };
}
