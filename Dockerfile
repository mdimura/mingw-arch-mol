# MingW64 + Qt5 for cross-compiling to Windows
# Based on ArchLinux image
FROM burningdaylight/mingw-arch:qt
MAINTAINER Mykola Dimura <mykola.dimura@gmail.com>

# Install AUR packages
USER devel
RUN yay -S --noconfirm --noprogressbar --needed \
        mingw-w64-spdlog-git \
        mingw-w64-async++-git \
        mingw-w64-libcuckoo-git \
        mingw-w64-readerwriterqueue-git

# Cleanup
USER root
RUN pacman -Scc --noconfirm
RUN paccache -r -k0; \
    rm -rf /usr/share/man/*; \
    rm -rf /tmp/*; \
    rm -rf /var/tmp/*;
    
USER devel
RUN yay -Scc

WORKDIR /workdir
ONBUILD USER root
ONBUILD WORKDIR /
