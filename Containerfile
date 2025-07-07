ARG BASE_IMAGE_NAME="sway-atomic"
ARG IMAGE_FLAVOR="-main"
ARG IMAGE_TAG="latest"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/

RUN rpm-ostree override remove \
    firefox \
    firefox-langpacks \
    foot && \
   # gnome-software \
   # malcontent-control && \
 ostree container commit

# Add some additional packages
RUN rpm-ostree install \
    breeze-cursor-theme \
    hplip \
    pam \
    pam-u2f \
    pamu2fcfg \
    ptyxis \
    yubikey-manager \
    yubikey-manager-qt && \
ostree container commit

# install flatpaks
RUN flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && \
    systemctl disable flatpak-add-fedora-repos.service && \
ostree container commit

#RUN flatpak install flathub \
#   org.mozilla.firefox \
#    io.github.flattool.Warehouse && \
#ostree container commit
    
