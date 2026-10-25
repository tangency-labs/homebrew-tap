# Homebrew tap for SolidCraft

```sh
brew install --cask tangency-labs/tap/solidcraft
```

This installs the universal macOS build of [SolidCraft](https://solidcraft.io/), open-source
parametric 3D CAD, from the [GitHub releases](https://github.com/tangency-labs/solidcraft/releases).
Upgrade with `brew upgrade --cask solidcraft`.

## Older versions

Every stable release from 0.6.0 on is available as a versioned cask:

```sh
brew install --cask tangency-labs/tap/solidcraft@0.21.0
```

A versioned cask conflicts with `solidcraft`, so uninstall one before installing the other. When a new
release comes out, the bump workflow generates the versioned cask for the release it replaces
(`scripts/gen-versioned.sh <version>` does it by hand). The CLI link is only included from 0.13.0 on,
because earlier releases don't bundle `solidcraft-cli`.

The app isn't signed and notarized yet, so the cask clears the quarantine flag after install.

A GitHub Action (`.github/workflows/bump.yml`) checks for a new stable release every six hours and updates the cask.
