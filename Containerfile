ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-$BASE_IMAGE_NAME-$IMAGE_FLAVOR}"
ARG IMAGE_TAG="${IMAGE_TAG:-latest}"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}-${IMAGE_FLAVOR} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/


# Add some additional packages
RUN rpm-ostree install \
    gamemode \
    gamescope \
    mangohud \
    pam \
    pam-u2f \
    pamu2fcfg \
    ulauncher \
    yubikey-manager \
    yubikey-manager-qt
  

# Remove some unwanted stuff
RUN rpm-ostree override remove \
  evtest \
  epson-inkjet-printer-escpr \
  epson-inkjet-printer-escpr2 \
  gnome-extensions-app \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-dash-to-dock \
  gnome-shell-extension-logo-menu \
  ifuse \
  input-leap \
  libgda-sqlite \
  libgda \
  rclone \
  restic \
  stress-ng \
  solaar \
  tailscale

# Remove additional kmods
RUN rm -f \
  /usr/lib/modules-load.d/v4l2loopback.conf \
  /usr/lib/modules-load.d/displaylink.conf

# Settings and service tweaks

RUN rm -rf \
  /tmp/* \
  /var/* && \
  ostree container commit
