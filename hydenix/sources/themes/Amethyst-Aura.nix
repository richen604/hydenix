{ pkgs, mkTheme }:
mkTheme rec {
  name = "Amethyst-Aura";
  src = pkgs.fetchFromGitHub {
    owner = "jackpawlik1";
    repo = "Amethyst-Aura";
    rev = "main";
    name = name;
    sha256 = "sha256-NjF0QQxqdYIxqv63Hgo9Waxa1arPfFXK65mRo0N9gvk=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Amethyst-Aura";
    homepage = "https://github.com/jackpawlik1/Amethyst-Aura";
    priority = 90;
  };
}
