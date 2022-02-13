<div align="center">

<h1>
    <img width="350" align="center" src="assets/dotfiles-logo.svg">
</h1>

[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square&labelColor=000000)](#license)

***My personal dotfiles for bash/zsh, vim, tmux, apt, brew.***

</div>

## Installation

1. Clone the dotfiles to your computer:

    ```bash
    $ git clone git@github.com:lento234/dotfiles.git
    $ cd dotfiles
    ```

2. Setup `bash` (or `zsh`), `vim`, `tmux`:

    ```bash
    $ ./setup-zsh.sh
    $ ./setup-vim.sh
    $ ./setup-tmux.sh
    ```
3. Install all apps from `list_of_apps.txt`:

    ```bash
    cat apt/list_of_apps.txt | xargs sudo apt install -y
    ```

4. Copy gitconfig to home dir and add your gpg key ID into gitconfig

    ```bash
    $ gpg --list-secret-keys --keyid-format=long # show your gpg key IDs
    $ git config --global user.signingkey <GPG_KEY_ID> # add gpg key ID into gitconfi
    ```

5. *(Optional)* Additional customization: `zsh` and custom prompt:

    1. [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): A delightful community-driven (with 1700+ contributors) framework for managing your zsh configuration.
    2. [Powerline fonts](https://github.com/powerline/fonts):  Patched fonts for Powerline users.
    3. [powerlevel10k](https://github.com/romkatv/powerlevel10k): A Zsh theme
    4. [liquidprompt](https://github.com/nojhan/liquidprompt):  A full-featured & carefully designed adaptive prompt for Bash & Zsh.

