<div align="center">

<h1>
    <img width="350" align="center" src="assets/dotfiles-logo.svg">
</h1>

[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square&labelColor=000000)](#license)

***My personal dotfiles: neovim, tmux, ghostty, bash, and a few
window managers (i3, sway, niri, awesome).***

</div>

## Dependencies

- terminal: [ghostty](https://ghostty.org/) or [kitty](https://sw.kovidgoyal.net/kitty/)
- font: a [Nerd Font](https://www.nerdfonts.com/font-downloads) (Lilex)
- prompt: [starship](https://starship.rs/)
- [neovim](https://neovim.io/) 0.12+ (uses the built-in `vim.pack`)
- [tmux](https://github.com/tmux/tmux) + [tpm](https://github.com/tmux-plugins/tpm)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [yazi](https://github.com/sxyazi/yazi)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [television](https://github.com/alexpasmantier/television)
- toolchains:
    - gcc
    - [rust](https://www.rust-lang.org/)
    - node via [nvm](https://github.com/nvm-sh/nvm)
    - [go](https://go.dev/)
    - [zig](https://ziglang.org/)

## Setup

1. Clone the repo:

    ```bash
    git clone git@github.com:lento234/dotfiles.git
    cd dotfiles
    ```

2. Symlink what you need (pick the host variant where there is one):

    ```bash
    ln -s "$PWD/.config/nvim" ~/.config/nvim
    ln -s "$PWD/.tmux.conf" ~/.tmux.conf
    ln -s "$PWD/.bashrc.<hostname>" ~/.bashrc
    ```

3. Install the tmux plugins (then, inside tmux, press `CTRL+B` `I`):

    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

4. *(Optional)* System configs under `.config/X11`, `.config/grub` and
   `.config/initramfs` are copied into `/etc`, not symlinked. See the README in
   each directory.

### Neovim

Plugins are managed with neovim's built-in `vim.pack`, declared in
[`lua/custom/pack.lua`](.config/nvim/lua/custom/pack.lua) and pinned in
`nvim-pack-lock.json`. They install on first launch; run `:PackUpdate` to
update them.

Mason installs the language servers, formatters and linters automatically.
These you need to install yourself:

- `git`, `curl`, a C compiler and [`tree-sitter`](https://github.com/tree-sitter/tree-sitter) CLI (to build parsers)
- `node`/`npm` (for many mason packages)
- `imagemagick` (snacks image preview)
- `lazygit` (`<leader>gl…` git keymaps)
- `zls` on your `PATH`, matching your zig version
- `terraform` / `terragrunt` for HCL formatting

## Links

- [nerd-fonts](https://github.com/ryanoasis/nerd-fonts): Iconic font aggregator, collection, & patcher.
- [starship](https://starship.rs): The minimal, blazing-fast, and infinitely customizable prompt for any shell.
- [catppuccin](https://github.com/catppuccin/catppuccin): The theme used for neovim and tmux.
- [awesome-copycats](https://github.com/lcpz/awesome-copycats): Source of the awesomewm `multicolor` theme.

## License

[MIT](LICENSE)
