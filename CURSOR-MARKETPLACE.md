# Cursor Marketplace submission

Submission URL: <https://cursor.com/marketplace/publish>

Repository URL:

```text
https://github.com/AICommander-dev/aicommander
```

## Listing copy

Name: **AI Commander**

Category: **Developer Tools**

Short description:

> Run commands, background jobs, screenshots, and file transfers on your own
> remote machines from Cursor.

Long description:

> AI Commander connects Cursor to computers you control without exposing SSH
> or opening inbound ports. Inspect machine availability, run one-off shell
> commands, manage long-running jobs that survive the conversation, capture
> explicitly enabled desktop screenshots, and transfer files through the
> authenticated AI Commander relay.

Support: `support@coderai.dev`

Privacy policy and terms: <https://aicommander.dev/privacy/>

Pricing disclosure:

> The Cursor plugin is free to install. AI Commander includes a Free service
> plan and optional paid Pro features. Current plan limits and purchase terms
> are disclosed before purchase and on the linked privacy-and-terms page.

## Reviewer test flow

Provide a disposable review account with at least one online machine. Do not
place credentials or machine identifiers in this repository.

1. Install the repository as a local plugin under
   `~/.cursor/plugins/local/aicommander` and reload Cursor.
2. Confirm **AI Commander** appears under **Settings → Plugins → Installed**.
3. Ask: “List my AI Commander machines and show which are online.”
4. Complete OAuth and verify that the seeded review machine is returned.
5. Ask: “Run `printf cursor-review-ok` on `[REVIEW_MACHINE]`.”
6. Confirm the command target and approve the tool call; verify the exact
   output `cursor-review-ok`.
7. Start `sleep 30` as a background job, check its status, then cancel it.

## OAuth compatibility

The server supports Cursor's current callback set:

- `https://www.cursor.com/agents/mcp/oauth/callback`
- `http://localhost:8787/callback`
- `cursor://anysphere.cursor-mcp/oauth/callback`

The custom-scheme URI is accepted as one exact allowlisted value. Other
`cursor://` values and arbitrary custom URI schemes remain rejected.

## Submission checklist

- [ ] Commit and push `.cursor-plugin/plugin.json`, `mcp.json`, `assets/logo.png`,
      `README.md`, `LICENSE`, and this checklist to the public repository.
- [ ] Deploy the OAuth callback compatibility change to production.
- [ ] Deploy the updated MCP tool annotations to production.
- [ ] Test the plugin from `~/.cursor/plugins/local/aicommander` after a clean
      **Developer: Reload Window**.
- [ ] Complete the reviewer flow with a disposable account and machine.
- [ ] Confirm the website, documentation, privacy policy, and support address
      are reachable without authentication.
- [ ] Submit the public GitHub repository at
      <https://cursor.com/marketplace/publish>.
- [ ] Do not publish reviewer credentials, tokens, or machine identifiers in
      the repository.
