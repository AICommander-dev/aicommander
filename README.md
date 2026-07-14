# AI Commander — Releases

Public release artifacts and checksums for [AI Commander](https://aicommander.dev) — secure remote access to your own computers for AI agents.

**This repository contains no source code.** It exists solely to host signed release binaries and their `SHA256SUMS` manifests via [GitHub Releases](https://github.com/AICommander-dev/aicommander/releases).

## Downloads

- Latest installers: <https://aicommander.dev/> (or [GitHub Releases](https://github.com/AICommander-dev/aicommander/releases/latest))
- Machine-readable release metadata: <https://aicommander.dev/dist/latest>
- Immutable versioned artifacts: `https://aicommander.dev/dist/v/<version>/`

## Verifying downloads

Every release ships a `SHA256SUMS` manifest covering all artifacts.

- **macOS** (DMG/PKG/ZIP): Apple Developer ID signed + notarized. Verify with `shasum -a 256 -c SHA256SUMS` (Gatekeeper additionally validates code signing on open).
- **Windows** (NSIS `.exe`): Authenticode-signed. Verify with `certutil -hashfile AICommander-Setup.exe SHA256` against the matching `SHA256SUMS` line.
- **Linux agent**: ships detached Ed25519 signatures (`.sig`) and `.sha256` files alongside the binary; the install flow at <https://aicommander.dev/howto/#install-agent> verifies them before running anything with sudo.

## Docs & support

- Documentation: <https://aicommander.dev/docs/>
- Issues & questions: open an issue in this repository.
