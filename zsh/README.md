# Zsh configuration

`~/.config/zsh/.zshrc` is the maintained interactive shell configuration. Zsh
loads it through a symlink at `~/.zshrc`.

On a new machine, preserve any existing `~/.zshrc` before creating the link:

```sh
ln -s "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
```

Open a new terminal to load the configuration. Cyan already has this symlink.
The home-directory symlink is outside this Git repository and must be installed
separately on each machine.

This configuration replaces Oh My Zsh with a standalone prompt, completion,
history, keybindings, Git aliases, and terminal-title hooks. It sources
`~/.bash_aliases`, which must exist and is maintained separately. NVM and Bun
integration is loaded when their files exist. Git powers the prompt; the
screen-recording functions require `ffmpeg` and `xrandr` in an X11 session.
This repository does not install these dependencies.
