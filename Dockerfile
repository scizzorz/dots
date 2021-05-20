# vim: set ft=dockerfile:
FROM archlinux:latest

# update all pacman packages and add some mirrors
RUN \
    pacman -Sy --noprogressbar --noconfirm \
 && pacman -S --noprogressbar --noconfirm sed \
 && curl -o /etc/pacman.d/mirrorlist "https://archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=6&use_mirror_status=on" \
 && sed -i 's/^#//' /etc/pacman.d/mirrorlist \
 && pacman -Sy --noprogressbar --noconfirm archlinux-keyring \
 && pacman -S --noprogressbar --noconfirm openssl \
 && pacman -S --noprogressbar --noconfirm pacman \
 && pacman-db-upgrade \
 && echo "[multilib]" >> /etc/pacman.conf \
 && echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
 && pacman -Syyu --noprogressbar --noconfirm

# lists of packages I like are stored in the packages dir and then pumped into
# the appropriate package managers.
ADD packages/ /packages/
RUN pacman -S --noprogressbar --noconfirm $(cat /packages/pacman)
RUN pip install $(cat /packages/pip)

# add a user and install dotfiles
ENV ME=john
RUN \
    groupadd sudo \
 && echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers \
 && useradd --create-home $ME -G sudo \
 && echo "$ME:spaghetti" | chpasswd \
 && chsh -s $(which zsh) $ME \
 && echo "Added user $ME"

# install user Rust/Python dev tools
RUN cd /home/$ME \
 && su $ME -c 'rustup default stable' \
 && su $ME -c 'rustup component add rustfmt clippy' \
 && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# install user dotfiles
ADD --chown=$ME:$ME . /home/$ME/dots
RUN \
    cd /home/$ME/dots \
 && su $ME -c './install.sh' \
 && cd .. \
 && mkdir .ssh \
 && chown $ME:$ME .ssh \
 && chmod 700 .ssh \
 && rm -f /etc/localtime \
 && ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

COPY docker/entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]

# expose ports that can be randomly published
EXPOSE 5000 5001 5002 5003 5004 8000

VOLUME /home/$ME/dev
WORKDIR /home/$ME
CMD ["/usr/bin/zsh"]
