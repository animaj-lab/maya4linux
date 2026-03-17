FROM rockylinux:9.3

ENV container=docker

# Dependencies
RUN dnf install -y epel-release
RUN dnf install -y \
        audiofile-devel \
        e2fsprogs-libs \
        fontconfig \
        freetype \
        libdrm \
        liberation-fonts-common \
        liberation-mono-fonts \
        liberation-sans-fonts \
        liberation-serif-fonts \
        libICE \
        libmng \
        libnsl \
        libpng15 \
        libSM \
        libX11 \
        libXau \
        libxcb \
        libXcomposite \
        libXcursor \
        libXdamage \
        libXext \
        libXfixes \
        libXi \
        libXinerama \
        libxkbcommon \
        libxkbcommon-x11 \
        libXmu \
        libXp \
        libXpm \
        libXrandr \
        libXrender \
        libXScrnSaver \
        libxshmfence \
        libXt \
        libXtst \
        mesa-libGLU \
        mesa-libGLw \
        nss \
        pciutils-libs \
        speech-dispatcher \
        xcb-util \
        xcb-util-image \
        xcb-util-keysyms \
        xcb-util-renderutil \
        xcb-util-wm \
        xorg-x11-fonts-ISO8859-1-100dpi \
        xorg-x11-fonts-ISO8859-1-75dpi \
        libxkbfile \
        nss \
        nss-util \
        nss-softokn-freebl \
        libEGL \
        libgomp \
        libglvnd \
        libglvnd-glx \
        libglvnd-egl \
        libglvnd-opengl \
        libtiff \
        libva \
        libvdpau \
        python3 \
        libwayland-cursor \
        harfbuzz \
        webkit2gtk3 \
        mesa-dri-drivers \
        xdg-utils \
        dbus \
        dbus-x11 \
        glib2 \
        xcb-util-cursor \
        libsecret \
        gnome-keyring \
        alsa-lib \
        gtk3 \
        cups-libs \
        atk \
        at-spi2-atk \
        compat-openssl11 \
        openssl-libs \
        libxcrypt-compat \
    && \
    dnf clean all && rm -rf /var/cache/dnf

# Installation folder
COPY Autodesk_Maya_2026_3_Update_Linux_64bit /install
RUN rm -rf /install/Packages/AdskIdentityManager
RUN rm -rf /install/Packages/adsklicensing*.rpm
COPY AdskIdentityManager-UCT-Installer/Packages/AdskIdentityManager/adskidentitymanager*.rpm /install/Packages
COPY adsklicensing*.rpm /install/Packages/

WORKDIR /install/Packages

# Licensing
RUN rpm -ivh --nodigest --nofiledigest --force adskidentitymanager*.rpm
RUN rpm -ivh --nodigest --nofiledigest --force adsklicensing*.rpm
RUN rpm -ivh --nodigest --nofiledigest --force adskflexnetclient*.rpm
RUN rpm -ivh --nodigest --nofiledigest --force adskflexnetserverIPV6*.rpm
RUN rpm -ivh --nodigest --nofiledigest --force adlmapps*.rpm
RUN rpm -ivh --nodigest --nofiledigest --force Maya2026*.rpm
RUN mkdir -p /var/opt/Autodesk/AdskLicensingService
RUN ln -s /opt/Autodesk/AdskLicensing/16.2.0.15195 /opt/Autodesk/AdskLicensing/Current
RUN ln -s /var/opt/Autodesk/Adlm/Maya2026 /var/opt/Autodesk/Adlm/Current
RUN ln -s /opt/Autodesk/AdskIdentityManager/1.18.1.2 /opt/Autodesk/AdskIdentityManager/Current

# User setup
ARG HOST_UID=1000
ARG HOST_GID=1000

# Create group if doesn't exist
RUN getent group ${HOST_GID} || groupadd -g ${HOST_GID} user

RUN useradd -u ${HOST_UID} -g ${HOST_GID} -m user
RUN usermod -aG video user
RUN groupadd -r render || true
RUN usermod -aG render user
ENV LD_LIBRARY_PATH=/opt/Autodesk/AdskLicensing/Current/AdskLicensingAgent/lib
RUN mkdir -p /var/lib/dbus && dbus-uuidgen > /var/lib/dbus/machine-id
WORKDIR /home/user

# Browser setup
RUN mkdir -p .local/share/applications .config
COPY browser/browser.sh browser.sh
COPY browser/host-browser.desktop .local/share/applications/host-browser.desktop
COPY browser/mimeapps.list .config/mimeapps.list
RUN chmod +x browser.sh && \
    xdg-mime default host-browser.desktop x-scheme-handler/http && \
    xdg-mime default host-browser.desktop x-scheme-handler/https

# Scripts
COPY docker_entrypoint.sh docker_entrypoint.sh
RUN chmod +x docker_entrypoint.sh

CMD ["/home/user/docker_entrypoint.sh"]
