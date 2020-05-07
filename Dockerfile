# MingW64 + Qt5 for cross-compiling to Windows
# Based on ArchLinux image
FROM burningdaylight/mingw-arch:qt
MAINTAINER Mykola Dimura <mykola.dimura@gmail.com>


USER devel
#Workaroung until mingw-w64-fmt-git is fixed
RUN cd /workdir && yay -G mingw-w64-fmt-git && \
        cd mingw-w64-fmt-git && \
        sed -i 's:mv "${pkgdir}"/usr/${_arch}/lib/..dll .*::g' PKGBUILD && \
        makepkg -si --noconfirm && \
        cd .. && rm -rf mingw-w64-fmt-git
# Install AUR packages
RUN yay -S --noconfirm --noprogressbar --needed \
        mingw-w64-spdlog-git \
        mingw-w64-async++-git \
        mingw-w64-libcuckoo-git \
        mingw-w64-readerwriterqueue-git \
        mingw-w64-pteros

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
