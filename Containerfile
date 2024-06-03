ARG BASE_IMAGE_NAME="silverblue"
ARG IMAGE_FLAVOR="-main"
ARG IMAGE_TAG="latest"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/

RUN curl https://copr.fedorainfracloud.org/coprs/kylegospo/system76-scheduler/repo/fedora-40/kylegospo-system76-scheduler-fedora-40

# Add some additional packages
RUN rpm-ostree install \
    gamemode \
    gamescope \
    gnome-shell-extension-system76-scheduler \
    gnome-shell-extension-user-theme \
    input-remapper \
    mangohud \
    pam \
    pam-u2f \
    pamu2fcfg \
    steam-devices \
    system76-scheduler
    ulauncher \
    yaru-theme \
    yubikey-manager \
    yubikey-manager-qt && \
ostree container commit