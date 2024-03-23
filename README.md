![peridot](https://github.com/b-wize/peridot/actions/workflows/build.yml/badge.svg)

A customized OCI Fedora silverblue with some preferred tweaks. 

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
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/b-wize/$peridot:latest

Reboot again to complete the installation
#
    systemctl reboot
