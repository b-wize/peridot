ARG BASE_IMAGE_NAME="silverblue"
ARG IMAGE_FLAVOR="-main"
ARG IMAGE_TAG="latest"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}${IMAGE_FLAVOR}:${IMAGE_TAG} AS peridot

# COPY system_files/yum.repos.d/google-chrome.repo /etc/yum.repos.d/

RUN rpm-ostree override remove \
    firefox \
    firefox-langpacks \
    gnome-software \
    malcontent-control && \
 ostree container commit

# Add some additional packages
RUN rpm-ostree install \
    breeze-cursor-theme \
    hplip \
    pam \
    pam-u2f \
    pamu2fcfg \
    ptyxis \
    solaar \
    ulauncher \
    yaru-theme \
    yubikey-manager \
    yubikey-manager-qt && \
ostree container commit

# install flatpaks
RUN flatpak install flathub \
    org.mozilla.firefox \
    io.github.dvlv.boxbuddyrs \
    com.mattjakeman.ExtensionManager \
    io.github.flattool.Warehouse \ 
    com.discordapp.Discord \
    com.github.IsmaelMartinez.teams_for_linux && \
ostree container commit
    
    
