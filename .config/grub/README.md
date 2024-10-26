1. Copy config

    ```bash
    cp grub.<hostname> /etc/default/grub
    ```

2. Rebuild grub

    ```bash
    grub2-mkconfig -o /boot/grub2/grub.cfg
    ```
