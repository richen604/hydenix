{ pkgs, mkTheme }:
mkTheme rec {
  name = "Amethyst-Aura";
  src = pkgs.fetchFromGitHub {
    owner = "jackpawlik1";
    repo = "Amethyst-Aura";
    rev = "821eb5523afb5920b9305dd2dc9206958cedd6a0";
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
