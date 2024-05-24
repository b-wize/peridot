ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-$BASE_IMAGE_NAME-$IMAGE_FLAVOR}"
ARG IMAGE_TAG="${IMAGE_TAG:-latest}"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}-${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/


# Add some additional packages
RUN rpm-ostree install \
    gamemode \
    gamescope \
    input-remapper \
    mangohud \
    pam \
    pam-u2f \
    pamu2fcfg \
    ulauncher \
    yubikey-manager \
    yubikey-manager-qt


# Install patched mesa
RUN rpm-ostree override remove \
    mesa-va-drivers-freeworld && \
rpm-ostree override replace \
--experimental \
--from repo=copr:copr.fedorainfracloud.org:kylegospo:bazzite-multilib \
    mesa-filesystem \
    mesa-libxatracker \
    mesa-libglapi \
    mesa-dri-drivers \
    mesa-libgbm \
    mesa-libEGL \
    mesa-vulkan-drivers \
    mesa-libGL \
    pipewire \
    pipewire-alsa \
    pipewire-gstreamer \
    pipewire-jack-audio-connection-kit \
    pipewire-jack-audio-connection-kit-libs \
    pipewire-libs \
    pipewire-pulseaudio \
    pipewire-utils \
    xorg-x11-server-Xwayland && \
rpm-ostree install \
    mesa-va-drivers-freeworld \
    mesa-vdpau-drivers-freeworld.x86_64 \
    libaacs \
    libbdplus \
    libbluray

# Install steam + deps    
RUN rpm-ostree install \
    at-spi2-core.i686 \
    atk.i686 \
    vulkan-loader.i686 \
    alsa-lib.i686 \
    fontconfig.i686 \
    gtk2.i686 \
    libICE.i686 \
    libnsl.i686 \
    libxcrypt-compat.i686 \
    libpng12.i686 \
    libXext.i686 \
    libXinerama.i686 \
    libXtst.i686 \
    libXScrnSaver.i686 \
    mesa-filesystem.i686 \
    NetworkManager-libnm.i686 \
    nss.i686 \
    pulseaudio-libs.i686 \
    libcurl.i686 \
    systemd-libs.i686 \
    libva.i686 \
    libvdpau.i686 \
    libdbusmenu-gtk3.i686 \
    libatomic.i686 \
    pipewire-alsa.i686 && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/fedora-updates.repo && \
rpm-ostree install \
    mesa-vulkan-drivers.i686 \
    mesa-va-drivers-freeworld.i686 \
    mesa-vdpau-drivers-freeworld.i686 && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree.repo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo && \
rpm-ostree install \
    steam && \
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo && \
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-updates.repo && \
  

# Remove some unwanted stuff
#RUN rpm-ostree override remove \
  #evtest 
  #epson-inkjet-printer-escpr \
  #epson-inkjet-printer-escpr2 \
  #gnome-extensions-app \
  #gnome-shell-extension-blur-my-shell \
  #gnome-shell-extension-dash-to-dock \
  #gnome-shell-extension-logo-menu \
  #ifuse \
  #input-leap \
  #libgda-sqlite \
  #libgda \
  #rclone \
  #restic \
  #stress-ng \
  #solaar \
  #tailscale


RUN mkdir /tmp/build.sh && \
ostree container commit



#rm -rf \
  #/tmp/* \
  #/var/* && \
  #/var/lib/alternatives && \
  
