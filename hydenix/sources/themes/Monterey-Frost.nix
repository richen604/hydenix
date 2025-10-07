{ pkgs, mkTheme }:
mkTheme rec {
  name = "Monterey Frost";
  src = pkgs.fetchFromGitHub {
    owner = "rishav12s";
    repo = "Monterey-Frost";
    rev = "4675ddd4abae2d86ce3d2c3940b29071ce1b4580";
    name = name;
    sha256 = "sha256-ECG7wyIa0RdZteTEdQjpVjhbf62XXz0rW3Ea494461E=";
  };
  meta = {
    description = "Mac-OS inspired dark theme";
    homepage = "https://github.com/rishav12s/Monterey-Frost";
  };
}
