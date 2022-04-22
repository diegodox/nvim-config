FROM anatolelucet/neovim:nightly

ARG USER_NAME="diegodox"
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:ja" \
    LC_ALL="en_US.UTF-8"
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    build-base \
    bash \
    wget \
    curl \
    github-cli \
    gzip \
    gcc \
    git \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    musl-dev\
    nodejs \
    npm \
    py-pip \
    python3-dev \
    py3-pip \
    ruby \
    ruby-dev \
    lazygit \
    ripgrep \
    fd \
    ranger \
    bat \
    neofetch \
    && \
    rm -rf /var/cache/apk/*

RUN pip3 install --upgrade pip pynvim

RUN adduser -S ${USER_NAME}
# Copy nvim config
# COPY . "${HOME}/.config/nvim"
COPY . "/home/${USER_NAME}/.config/nvim"
# Have copied config file owned by user
RUN chown -R "${USER_NAME}" "/home/${USER_NAME}"
USER ${USER_NAME}
ENV PATH $PATH:/home/${USER_NAME}/.local/share/nvim

# Preinstall plugins, found: https://github.com/wbthomason/packer.nvim/issues/599
# BUG: All plugins can't loaded...
# RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

WORKDIR "/home/${USER_NAME}/.config/nvim"

# Run nvim on .config/nvim directory at startup
ENTRYPOINT ["nvim", "."]
