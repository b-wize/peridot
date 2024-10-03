ARG BASE_IMAGE_NAME="kinoite"
ARG IMAGE_FLAVOR="-main"
ARG IMAGE_TAG="latest"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/

RUN rpm-ostree override remove \
    firefox \
    firefox-langpacks && \
ostree container commit

# Add some additional packages
RUN rpm-ostree install \
    input-remapper \
    pam \
    pam-u2f \
    pamu2fcfg \
    steam-devices \
    ulauncher \
    yaru-theme \
    yubikey-manager \
    yubikey-manager-qt && \
ostree container commit
