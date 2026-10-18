This is my neovim config.

It should be cloned to `~/.config/`; the contents will then live in `~/.config/nvim/` (this repo.)

Next, open neovim (probably `nvim`, or `nv` if you're me) and do `:Lazy` and then install all the plugins with `I`.

Plugins live in `~/.local/share/nvim/`.

Lean support loads when opening a `.lean` file. Install Lean through `elan` and
keep `lean` and `lake` on `PATH`; a project's `lean-toolchain` selects its version.
The language server, completion, Unicode abbreviations, and goal infoview start
automatically. No separate Lean server needs to be installed through Mason.

With the local leader set to `\`, use `\i` to toggle the infoview, `\<Tab>` to
move into it, and `\x` to pin a goal. In insert mode, type `\alpha` followed by
space to insert `α`. See `:help lean` and `:checkhealth lean` after opening a Lean
file for more commands and troubleshooting.

To install missing plugins without upgrading existing ones, use `:Lazy install`
(avoid `:Lazy update` or `:Lazy sync` when preserving versions).
