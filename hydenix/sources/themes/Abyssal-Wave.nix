{ pkgs, mkTheme }:
mkTheme rec {
  name = "Abyssal-Wave";
  src = pkgs.fetchFromGitHub {
    owner = "Itz-Abhishek-Tiwari";
    repo = "Abyssal-Wave";
    # locking commit
    rev = "1f6eff0eb85ed05ac2c402d9e608cc70a3bb16a0";
    name = name;
    sha256 = "sha256-VpKPKgRQMQhDWmlrFignZ1tN69MB/cd8KBsAARMIKIo=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Abyssal-Wave";
    homepage = "https://github.com/Itz-Abhishek-Tiwari/Abyssal-Wave";
    priority = 10;
  };
}
