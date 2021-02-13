<div align="center">

# `.dotfiles`

***My personal dotfiles for bash/zsh, vim, tmux, apt, brew***

</div>
  
## Installation

1. Clone the dotfiles to your computer:

    ```bash
    $ git clone git@github.com:lento234/dotfiles.git
    $ cd dotfiles
    ```

2. Setup `bash` (or `zsh`), `vim`, `tmux`:

    ```bash
    $ ./setup-bash.sh
    $ ./setup-vim.sh
    $ ./setup-tmux.sh
    ```
3. Install all apps from `list_of_apps.txt`:

    ```bash
    cat apt/list_of_apps.txt | xargs sudo apt install -y
    ```

4. *(Optional)* Additional customization: `zsh` and custom prompt:

    1. [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): A delightful community-driven (with 1700+ contributors) framework for managing your zsh configuration. 
    2. [Powerline fonts](https://github.com/powerline/fonts):  Patched fonts for Powerline users. 
    3. [powerlevel10k](https://github.com/romkatv/powerlevel10k): A Zsh theme
    4. [liquidprompt](https://github.com/nojhan/liquidprompt):  A full-featured & carefully designed adaptive prompt for Bash & Zsh 
