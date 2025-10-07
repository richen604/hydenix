{ pkgs, mkTheme }:
mkTheme rec {
  name = "Abyssal-Wave";
  src = pkgs.fetchFromGitHub {
    owner = "Itz-Abhishek-Tiwari";
    repo = "Abyssal-Wave";
    # locking commit
    rev = "main";
    name = name;
    sha256 = "sha256-JMYjNV2r6/lRwKNQFdz2HmZH7ZxLO0MdiO2iUi5R7As=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Abyssal-Wave";
    homepage = "https://github.com/Itz-Abhishek-Tiwari/Abyssal-Wave";
  };
}
