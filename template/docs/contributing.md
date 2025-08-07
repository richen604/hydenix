<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# contributing

this project uses [direnv](https://direnv.net/) for pre-commit hooks. please install it first:

- **nix**: `nix-env -iA nixpkgs.direnv`
- **macos**: `brew install direnv`
- **ubuntu/debian**: `apt-get install direnv`

then run `direnv allow` to enable the hooks

more documentation on the codebase can be found at [template README](template/README.md)

this project enforces [conventional commits](https://www.conventionalcommits.org/) format for all commit messages. each commit message must follow this structure:

```bash
type(optional-scope): subject

[optional body]

[optional footer(s)]
```

where:

- **type** must be one of:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation changes
  - `style`: Code style changes (formatting, etc)
  - `refactor`: Code changes that neither fix bugs nor add features
  - `perf`: Performance improvements
  - `test`: Adding or modifying tests
  - `chore`: Maintenance tasks

- **scope** is optional but if used:
  - must be lowercase
  - should be descriptive of the area of change
  - examples: vm, themes, home, cli, docs, etc.

- **subject** must:
  - not end with a period
  - be descriptive

examples:

- `feat(vm): add support for fedora vm configuration`
- `fix: correct wallpaper path in material theme`
- `docs: update installation instructions`
- `chore: update dependencies`

## pull requests

1. fork the repository
2. create your feature branch (`git checkout -b feature/amazing-feature`)
3. commit your changes using conventional commits
4. push to the branch (`git push origin feature/amazing-feature`)
5. open a pull request

## changelog

the changelog is automatically generated from commit messages. clear, well-formatted commit messages ensure your changes are properly documented.

for more details, see the [conventional commits specification](https://www.conventionalcommits.org/).
