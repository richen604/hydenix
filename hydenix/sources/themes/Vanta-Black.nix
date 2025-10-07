{ pkgs, mkTheme }:
mkTheme rec {
  name = "Vanta Black";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Vanta-Black";
    rev = "2ad0f0c041bd90479f4b5e94e139804c2264d8ae";
    name = name;
    sha256 = "sha256-4UZSpJPIzs2ZLQMt1QQz7VoyDW4jiOWZ9Xp1yU4k4Zs=";
  };
  meta = {
    description = "HyDE Theme: Vanta Black inspired theme having the deepest blacks";
    homepage = "https://github.com/rishav12s/Vanta-Black";
  };
}
