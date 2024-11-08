
1. Copy config:

    ```bash
    cp modprobe.d/vfio.conf /etc/modprobe.d/
    cp dracut.conf.d/10-vfio.conf /etc/dracut.conf.d/10-vfio.conf
    cp modules.load.d/vfio-pci.conf /etc/modules-load.d/vfio-pci.conf
    ```

2. Rebuild initramfs:

    arch:
    ```bash
    mkinitcpio -p linux
    ```

    rhel-based:
    ```bash
    dracut -fv
    ```

3. Check

    ```bash
    lsinitrd | grep -i vfio
    ```

    ```bash
    dmesg | grep -i iommu
    ```

    ```bash
    lspci -k | grep vfio -b2
    ```
