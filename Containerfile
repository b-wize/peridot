ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-main}"
ARG IMAGE_TAG="$}{MAGE_TAG:-latest}"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${IMAGE_TAG} AS peridot

COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/

# Gnome VRR
RUN wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-gnome-vrr-fedora-"${FEDORA_MAJOR_VERSION}".repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo && \
rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:kylegospo:gnome-vrr mutter mutter-common gnome-control-center gnome-control-center-filesystem && \
rm -f /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo && \
wget https://copr.fedorainfracloud.org/coprs/kylegospo/prompt/repo/fedora-$(rpm -E %fedora)/kylegospo-prompt-fedora-$(rpm -E %fedora).repo?arch=x86_64 -O /etc/yum.repos.d/_copr_kylegospo-prompt.repo && \
rpm-ostree override replace \
  --experimental \
  --from repo=copr:copr.fedorainfracloud.org:kylegospo:prompt \
  vte291 \
  vte-profile \
  libadwaita && \
  rpm-ostree install \
  ptyxis && \
  rm -f /etc/yum.repos.d/_copr_kylegospo-prompt.repo && \
  rpm-ostree override remove \
  power-profiles-daemon \
  || true && \
  rpm-ostree override remove \
  tlp \
  tlp-rdw \
  || true

# Add some additional packages
RUN rpm-ostree install \
  gamescope \
  mangohud \
  lm_sensors \
  solaar \ 
  hplip \
  google-chrome-stable

# Remove some unwanted stuff
RUN rpm-ostree override remove \
firefox
firefox-langpacks



rm -rf \
/tmp/* \
/var/* && \
ostree container commit