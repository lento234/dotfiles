# dotfiles
  
My personal dotfiles (bash/zsh, vim)
  
## Installation

1. Clone the dotfiles to your computer:

    ```bash
    git clone git@github.com:lento234/dotfiles.git
    ```

2. Install `vim` settings and plugins using `vundle`:

    ```bash
    cd dotfiles
    ./vimsetup.sh
    ```

3. Link the bash aliases to your `.bashrc` or `.zshrc`:

    1. Make an symlink to home dir:
    
        ```bash
        ln -s bash/.aliases ~/.aliases
        ```

    2. source `.aliases` in `.bashrc` or `.zshrc`:

        ```bash
        if [ -f ~/.bash_aliases ]; then
            . ~/.bash_aliases
        fi
        ```

4. *(Optional)* Additional customization: `zsh` and custom prompt:

    1. [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): A delightful community-driven (with 1700+ contributors) framework for managing your zsh configuration. 
    2. [Powerline fonts](https://github.com/powerline/fonts):  Patched fonts for Powerline users. 
    3. [powerlevel10k](https://github.com/romkatv/powerlevel10k): A Zsh theme
    4. [liquidprompt](https://github.com/nojhan/liquidprompt):  A full-featured & carefully designed adaptive prompt for Bash & Zsh 
