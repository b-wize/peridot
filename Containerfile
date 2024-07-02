ARG BASE_IMAGE_NAME="silverblue"
ARG IMAGE_FLAVOR="-main"
ARG IMAGE_TAG="latest"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/


# Add some additional packages
RUN rpm-ostree install \
    breeze-cursor-theme \
    gamemode \
    gamescope \
    gnome-shell-extension-user-theme \
    input-remapper \
    lm-sensors \
    mangohud \
    pam \
    pam-u2f \
    pamu2fcfg \
    steam-devices \
    ulauncher \
    yaru-theme \
    yubikey-manager \
    yubikey-manager-qt && \
ostree container commit
