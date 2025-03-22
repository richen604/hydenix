# Contributing

This project uses [direnv](https://direnv.net/) for pre-commit hooks. Please install it first:

- **Nix**: `nix-env -iA nixpkgs.direnv`
- **MacOS**: `brew install direnv`
- **Ubuntu/Debian**: `apt-get install direnv`

then run `direnv allow` to enable the hooks

More documentation on the codebase can be found at [Template README](template/README.md)

This project enforces [Conventional Commits](https://www.conventionalcommits.org/) format for all commit messages. Each commit message must follow this structure:

```bash
type(optional-scope): subject

[optional body]

[optional footer(s)]
```

Where:

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
  - be lowercase
  - not end with a period
  - be descriptive

Examples:

- `feat(vm): add support for fedora vm configuration`
- `fix: correct wallpaper path in material theme`
- `docs: update installation instructions`
- `chore: update dependencies`

## Pull Requests

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes using conventional commits
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Changelog

The changelog is automatically generated from commit messages. Clear, well-formatted commit messages ensure your changes are properly documented.

For more details, see the [Conventional Commits specification](https://www.conventionalcommits.org/).