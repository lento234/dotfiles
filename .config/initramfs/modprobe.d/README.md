
1. Copy config:

    ```bash
    cp vfio.conf /etc/modprobe.d/
    ```

2. Rebuild initramfs:

    arch:
    ```bash
    mkinitcpio -p linux
    ```

    rhel-based:
    ```bash
    dracut --regenerate-all
    ```
