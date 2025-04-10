<div align="center">

<h1>
    <img width="350" align="center" src="assets/dotfiles-logo.svg">
</h1>

[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square&labelColor=000000)](#license)

***My personal dotfiles for shell (bash, zsh), neovim, tmux, i3, and awesomewm.***

</div>

## Dependencies

- bash
- terminal: [kitty](https://sw.kovidgoyal.net/kitty/)
- prompt: [starship](https://starship.rs/)
- font: [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads)
- compilers: [rust](https://www.rust-lang.org/), npm ([nvm](https://github.com/nvm-sh/nvm)), [golang](https://go.dev/), [zig](https://ziglang.org/), gcc
- [neovim](https://neovim.io/) 0.10.+
- [tmux](https://github.com/tmux/tmux)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [yazi](https://github.com/sxyazi/yazi)
- [lazygit](https://github.com/jesseduffield/lazygit)

## Setup

1. Clone the dotfiles to your computer:

    ```bash
    $ git clone git@github.com:lento234/dotfiles.git
    $ cd dotfiles
    ```

2. Configure dotfiles (rename destination if needed):

    ```bash
    $ ln -s <src> <dst>
    ```

3. (*Optional*): Additional tmux setup, install plugins (then, in tmux
   `CTRL+B`, `I`):

    ```bash
    $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

### Neovim setup

Requirements:

 - image.nvim:
  - imagemagick
  - pkg-config

## Links

### Themeing

- [Powerline fonts](https://github.com/powerline/fonts): Patched fonts for
  Powerline users.
- [nerd-fonts](https://github.com/ryanoasis/nerd-fonts): Iconic font
  aggregator, collection, & patcher.
- [FiraCode](https://github.com/tonsky/FiraCode): Free monospaced font with
  programming ligatures.

### Prompts

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): A delightful
  community-driven (with 1700+ contributors) framework for managing your zsh
  configuration.
- [powerlevel10k](https://github.com/romkatv/powerlevel10k): A Zsh theme
- [liquidprompt](https://github.com/nojhan/liquidprompt):  A full-featured &
  carefully designed adaptive prompt for Bash & Zsh.
- [startship](https://starship.rs): The minimal, blazing-fast, and infinitely
customizable prompt for any shell!

### Awesomewm

- [awesome](https://github.com/awesomeWM/awesome): https://github.com/awesomeWM/awesome
- [awesome-copycats](https://github.com/lcpz/awesome-copycats): Awesome WM themes
- [yoru](https://github.com/rxyhn/yoru): 夜 - Yoru | Aesthetic and Beautiful Awesome Environment 🌓.

