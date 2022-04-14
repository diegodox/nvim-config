FROM anatolelucet/neovim:nightly

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    build-base \
    curl \
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
    && \
    rm -rf /var/cache/apk/*

RUN pip3 install --upgrade pip pynvim

# Copy nvim config
COPY . /root/.config/nvim

RUN chmod -R 777 /root

ENTRYPOINT ["nvim"]
