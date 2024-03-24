ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-bluefin}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-$BASE_IMAGE_NAME-$IMAGE_FLAVOR}"
ARG IMAGE_TAG="${IMAGE_TAG:-latest}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-39}"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${IMAGE_TAG} AS peridot

COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/

# Add some additional packages
RUN rpm-ostree install \
  gamescope \
  mangohud \
  lm_sensors \
  gamemode
  #google-chrome-stable

# Remove some unwanted stuff
RUN rpm-ostree override remove \
  evtest \
  cockpit-bridge \
  epson-inkjet-printer-escpr \
  epson-inkjet-printer-escpr2 \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-dash-to-dock \
  gnome-shell-extension-logo-menu \
  ifuse \
  input-leap \
  input-remapper \
  libgda-sqlite \
  libgda \
  rclone \
  restic \
  stress-ng \
  tailscale

# Remove some extra flatpaks
RUN flatpak remove \
  org.gnome.Calendar \
  org.gnome.maps

# Settings and service tweaks

RUN rm -rf \
  /tmp/* \
  /var/* && \
  ostree container commit
