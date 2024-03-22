Rebasing
To rebase an existing Silverblue/Kinoite installation to the latest build:

First rebase to the unsigned image, to get the proper signing keys and policies installed:
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/secureblue/$IMAGE_NAME:latest

Reboot to complete the rebase:
systemctl reboot

Then rebase to the signed image, like so:
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/secureblue/$IMAGE_NAME:latest

Reboot again to complete the installation
systemctl reboot
