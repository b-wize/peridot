![peridot](https://github.com/b-wize/peridot/actions/workflows/build.yml/badge.svg?branch=main)


![image](https://github.com/b-wize/peridot/assets/29105401/8233800a-b9bb-4d98-882c-c707cd2febd2)




A customized OCI Fedora 42 with some preferred tweaks. 

Big thanks to everyone working on the [Universal Blue](https://github.com/ublue-os) and [Bazzite](https://github.com/ublue-os/bazzite) projects.

Rebasing
To rebase an existing Silverblue/Kinoite installation to the latest build:

First rebase to the unsigned image, to get the proper signing keys and policies installed:
# 
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/b-wize/peridot:latest

Reboot to complete the rebase:
#
    systemctl reboot

Then rebase to the signed image, like so:
#
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/b-wize/peridot:latest

Reboot again to complete the installation
#
    systemctl reboot

Again, this project would not be possible without all the hard work contributed to the Universal Blue (Ublue) and Bazzite projects.
