# MingW64 + Qt5 for cross-compiling to Windows
# Based on ArchLinux image
FROM burningdaylight/mingw-arch:qt
MAINTAINER Mykola Dimura <mykola.dimura@gmail.com>

USER devel

# Install AUR packages
RUN export MAKEFLAGS="-j$(nproc)"
RUN yay -S --noconfirm --noprogressbar --needed \
        mingw-w64-fmt \
        mingw-w64-spdlog-git \
        mingw-w64-async++-git \
        mingw-w64-libcuckoo-git \
        mingw-w64-readerwriterqueue-git \
        mingw-w64-pteros
USER root
RUN ln -s /usr/x86_64-w64-mingw32/include/eigen3/Eigen /usr/x86_64-w64-mingw32/include/Eigen; \
    ln -s /usr/i686-w64-mingw32/include/eigen3/Eigen /usr/i686-w64-mingw32/include/Eigen;

# Cleanup
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
