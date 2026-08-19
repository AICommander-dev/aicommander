# AI Commander

AI Commander gives AI agents secure remote access to computers you control.
It can inspect machine availability, run shell commands, manage detached
background jobs, capture opted-in desktop screenshots, and transfer files
without exposing SSH or opening inbound ports.

This public repository contains:

- the open-source AI Commander plugin for Cursor;
- signed application release artifacts and their checksums through GitHub
  Releases.

It does not contain the proprietary source code of the AI Commander desktop
application, machine agent, or hosted relay service.

## Cursor plugin

The plugin connects Cursor to the hosted Streamable HTTP MCP endpoint:

```text
https://aicommander.dev/mcp
```

Cursor starts the OAuth flow when account access is needed. After signing in,
the plugin can work with machines linked to that AI Commander account. Tool
calls that execute commands, stop jobs, or write files can change or delete
data on the selected machine; review the target and requested action before
approving them in Cursor.

Installing the plugin is free. The hosted AI Commander service provides a Free
plan and optional paid Pro features; current plan limits and purchase terms are
described on the public privacy-and-terms page linked below.

### Test locally

1. Clone this repository into
   `~/.cursor/plugins/local/aicommander`.
2. In Cursor, run **Developer: Reload Window**.
3. Open **Settings → Plugins → Installed** and confirm that **AI Commander** is
   present.
4. Ask: “List my AI Commander machines and show which are online.”
5. Complete OAuth when Cursor opens the AI Commander sign-in page.

The plugin consists of the manifest at
`.cursor-plugin/plugin.json`, the MCP configuration at `mcp.json`, and the
marketplace logo at `assets/logo.png`. Its version is independent of desktop,
agent, and hosted-service release numbers.

## Downloads

- Latest installers: <https://aicommander.dev/> or
  [GitHub Releases](https://github.com/AICommander-dev/aicommander/releases/latest)
- Machine-readable release metadata: <https://aicommander.dev/dist/latest>
- Immutable versioned artifacts: `https://aicommander.dev/dist/v/<version>/`

## Verifying downloads

Every release ships a `SHA256SUMS` manifest covering all artifacts.

- **macOS**: DMG, PKG, and ZIP artifacts are Apple Developer ID signed and
  notarized. Verify checksums with `shasum -a 256 -c SHA256SUMS`.
- **Windows**: the NSIS installer is Authenticode-signed. Verify its checksum
  with `certutil -hashfile AICommander-Setup.exe SHA256`.
- **Linux agent**: detached Ed25519 signatures and `.sha256` files are
  published alongside the binary. The documented install flow verifies them
  before running anything with elevated privileges.

## Documentation and support

- Documentation: <https://aicommander.dev/docs/>
- Setup guide: <https://aicommander.dev/howto/>
- Privacy policy and terms: <https://aicommander.dev/privacy/>
- Support: <support@coderai.dev>
- Issues and questions: use this repository's issue tracker.

## License scope

The Cursor plugin manifest and MCP configuration in this repository are
available under the MIT License. AI Commander trademarks, release binaries,
desktop and agent applications, and the hosted service are not relicensed by
that grant and remain subject to their applicable product terms.
