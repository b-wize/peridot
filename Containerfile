ARG BASE_IMAGE_NAME="kinoite"
ARG IMAGE_FLAVOR="-main"
ARG IMAGE_TAG="latest"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

#install starship
#curl -sS https://starship.rs/install.sh | sh

RUN rpm-ostree override remove \
    firefox \
    firefox-langpacks \
    kde-connect \
    kdeconnectd \
    kde-connect-libs \
    kate \
    kate-libs \
    kate-plugins \
    kate-krunner-plugins \
    kwrite \
    plasma-discover \
    plasma-discover-libs \
    plasma-discover-flatpak \
    plasma-discover-notifier \ 
    plasma-discover-kns && \
ostree container commit

# Add some additional packages
RUN rpm-ostree install \
    hplip \
    pam \
    pam-u2f \
    pamu2fcfg \
    ulauncher \
    yubikey-manager \
    yubikey-manager-qt && \
ostree container commit

# remove kde flatpaks


# install flatpaks
RUN flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && \
    systemctl disable flatpak-add-fedora-repos.service && \
ostree container commit

#RUN flatpak install flathub -y \
#    org.mozilla.firefox \
#    io.github.kolunmi.Bazaar \
#    com.github.tchx84.Flatseal && \
#ostree container commit
    
