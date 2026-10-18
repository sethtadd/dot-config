# Zsh configuration

`~/.config/zsh/.zshrc` is the maintained interactive shell configuration. Zsh
loads it through a symlink at `~/.zshrc`.

On a new machine, preserve any existing `~/.zshrc` before creating the link:

```sh
ln -s "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
```

Open a new terminal to load the configuration. The home-directory symlink is
outside this Git repository and must be installed separately on each machine.

The shared configuration optionally sources `~/.bash_aliases`, then
`~/.zshrc.local`, before defining its own prompt and aliases. Keep machine paths,
work initialization, and credentials in the private `~/.zshrc.local` file outside
this repository. Loading local setup first preserves shared Git aliases such as
`gp` (`git push`) even when work helpers define different aliases or a prompt.
Restrict a local file containing credentials to its owner (`chmod 600`).

This configuration replaces Oh My Zsh with a standalone prompt, completion,
history, keybindings, Git aliases, and terminal-title hooks. It explicitly defines
`n` as `nvim`, independently of the optional `~/.bash_aliases`. NVM and Bun
integration is loaded when their files exist. Google Cloud completion loads when
`~/google-cloud-sdk/completion.zsh.inc` exists, after completion initialization;
SDK PATH setup belongs in the local file. Other startup files, including
`~/.zprofile` and `~/.zshenv`, remain machine-local.

Git powers the prompt; the screen-recording functions require `ffmpeg` and
`xrandr` in an X11 session. This repository does not install these dependencies.
