# vim: set ft=dockerfile:
FROM archlinux/base

RUN \
    pacman -Sy --noprogressbar --noconfirm \
 && pacman -S --noprogressbar --noconfirm sed \
 && curl -o /etc/pacman.d/mirrorlist "https://www.archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=6&use_mirror_status=on" \
 && sed -i 's/^#//' /etc/pacman.d/mirrorlist \
 && pacman -Sy --noprogressbar --noconfirm archlinux-keyring \
 && pacman -S --noprogressbar --noconfirm openssl \
 && pacman -S --noprogressbar --noconfirm pacman \
 && pacman-db-upgrade \
 && echo "[multilib]" >> /etc/pacman.conf \
 && echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
 && pacman -Syyu --noprogressbar --noconfirm

RUN \
    pacman -S --noprogressbar --noconfirm \
           aws-cli \
           base-devel \
           bat \
           cmake \
           docker \
           exa \
           fd \
           git \
           httpie \
           iputils \
           jq \
           man \
           openssh \
           python \
           python-pip \
           ripgrep \
           rustup \
           sd \
           skim \
           terraform \
           thefuck \
           tmux \
           tokei \
           vim \
           wget \
           zsh \
           zsh-syntax-highlighting \
 && pip install \
        pipenv \
        flake8 \
        pylint

# Add a user and install dotfiles
RUN \
    groupadd sudo \
 && echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers \
 && useradd --create-home john -G sudo \
 && echo "john:spaghetti" | chpasswd \
 && chsh -s $(which zsh) john \
 && cd /home/john \
 && su john -c 'rustup default stable' \
 && su john -c 'rustup component add rustfmt clippy' \
 && git clone https://github.com/scizzorz/dots.git \
 && chown -R john:john dots \
 && cd dots \
 && su john -c './install.sh' \
 && su john -c 'python vim/bundle/youcompleteme/install.py --clang-completer --rust-completer' \
 && cd .. \
 && mkdir .ssh \
 && chown john:john .ssh \
 && chmod 700 .ssh \
 && rm -f /etc/localtime \
 && ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

COPY docker/entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]

# expose ports that can be randomly published
EXPOSE 5000
EXPOSE 5001
EXPOSE 5002
EXPOSE 5003
EXPOSE 5004

VOLUME /home/john/dev
WORKDIR /home/john
CMD ["/usr/bin/zsh"]
