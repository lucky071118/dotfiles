# dotfiles

Personal dotfiles for **GitHub Codespaces** and general Unix/Linux development environments.

## What's included

| File | Purpose |
|------|---------|
| `install.sh` | Entry-point script run automatically by GitHub Codespaces |
| `.bashrc` | Bash interactive shell config (prompt, aliases, functions) |
| `.gitconfig` | Git defaults, aliases, and URL shortcuts |
| `.gitignore_global` | Global git ignore patterns (linked by `.gitconfig`) |
| `.vimrc` | Vim configuration with vim-plug plugins |
| `.profile` | POSIX login shell config (sources `.bashrc` for bash) |

## Usage with GitHub Codespaces

1. Go to **GitHub Settings → Codespaces → Dotfiles**.
2. Select this repository as your dotfiles repository.
3. GitHub Codespaces will automatically clone this repo and run `install.sh` when a new codespace is created.

## Manual installation

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

## What `install.sh` does

* Creates symlinks in `$HOME` for each dotfile listed above.
* Backs up any existing file to `<file>.bak` before symlinking.
* Installs [vim-plug](https://github.com/junegunn/vim-plug) and all Vim plugins declared in `.vimrc`.

## Customisation tips

* **Git identity** – uncomment and fill in `[user] name` and `email` in `.gitconfig`, or just run `git config --global user.name "..."` which will write to `~/.gitconfig`.
* **Shell** – GitHub Codespaces uses **bash** by default. All shell customisation lives in `.bashrc`.
* **Vim plugins** – add `Plug` lines in `.vimrc` and run `:PlugInstall` inside Vim.