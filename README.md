# Codespaces Dotfiles

Personal dotfiles for GitHub Codespaces. Workflow is VS Code first with minimal terminal use.

## How It Works

- **Extensions and editor preferences** are handled by VS Code Settings Sync.
- **`install.sh`** applies configurations not covered by Settings Sync.

## What Gets Applied

### `.editorconfig`

Covers Python and Node.js projects with mainstream defaults:

| File type | Indent | Standard |
|---|---|---|
| `*.py` | 4 spaces | PEP 8, Black |
| `*.js` `*.ts` `*.jsx` `*.tsx` | 2 spaces | Prettier, StandardJS |
| `*.json` `*.yaml` | 2 spaces | npm / GitHub Actions ecosystem |
| `*.md` | — | trailing whitespace preserved |
| `Makefile` | tabs | required by make |

All files default to UTF-8, LF line endings, and a trailing newline.

### `.gitconfig`

| Setting | Value | Reason |
|---|---|---|
| `pull.rebase` | `false` | Always merge on pull, no surprise rebases |
| `push.default` | `current` | Push current branch without specifying remote |
| `push.autoSetupRemote` | `true` | No need to run `--set-upstream` manually |
| `init.defaultBranch` | `main` | Consistent default branch name |
| `core.autocrlf` | `input` | Normalize line endings to LF on Codespaces |
| `merge.conflictstyle` | `zdiff3` | Clearer conflict markers |
| `rerere.enabled` | `true` | Remembers past conflict resolutions |

### Global CLI

`install.sh` also installs OpenSpec from its official npm package:

```bash
npm install -g @fission-ai/openspec@latest
```

This only runs when both `node` and `npm` are available and Node.js is `20.19.0` or newer, which matches the upstream prerequisite.

The install target is configurable through the `OPENSPEC_VERSION` environment variable. By default this repo installs `latest`, but you can pin a version during setup, for example:

```bash
OPENSPEC_VERSION=1.4.2 ./install.sh
```

If the OpenSpec install fails, the script prints the reason and continues applying the rest of the dotfiles instead of aborting the whole setup.

### Copilot Customizations Sync

`install.sh` syncs these folders into the active workspace under `.github/`:

- `skills`
- `prompts`

The sync is non-destructive by default (existing files are not overwritten), so local repository customizations remain intact.

You can disable this behavior for a run:

```bash
SYNC_COPILOT_CUSTOMIZATIONS=0 ./install.sh
```

## Setup

1. Go to **GitHub Settings → Codespaces → Dotfiles**
2. Set this repository as your dotfiles repository
3. Every new Codespace will run `install.sh` automatically

## Future Additions

Things that belong in dotfiles (not covered by Settings Sync):

- Shell aliases or environment variables via `.bashrc` or `.bash_profile`
- Language version pinning via `.python-version` or `.nvmrc` defaults
