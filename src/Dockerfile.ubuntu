

FROM ubuntu:20.04

ARG USERNAME=qs5779
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG PY_VERSION=3.10.7

ENV PYTHON_VERSION=$PY_VERSION
ENV DEBIAN_FRONTEND noninteractive

# https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.source="https://github.com/qs5779/python-images"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Quien Sabe <qs5779@mail.com>"
LABEL org.opencontainers.image.description="python version ${PYTHON_VERSION} with peotry installed into Ubuntu LTS 20.04"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    liblzma-dev \
    lzma-dev \
    lzma \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    git \
    ca-certificates \
    libffi-dev \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /var/cache/apt/archives/*.deb

# Create user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# Install ``pyenv``.
RUN git clone https://github.com/pyenv/pyenv /home/${USERNAME}/.pyenv

# Install the desired versions of Python.
RUN set -ex \
    && /home/${USERNAME}/.pyenv/bin/pyenv install ${PYTHON_VERSION} \
    && /home/${USERNAME}/.pyenv/versions/${PYTHON_VERSION}/bin/python -m pip install --upgrade pip \
    && /home/${USERNAME}/.pyenv/versions/${PYTHON_VERSION}/bin/python -m pip install poetry

# Add to PATH
ENV PATH /home/${USERNAME}/.pyenv/versions/${PYTHON_VERSION}/bin:${PATH}

WORKDIR /project

CMD ["/bin/bash"]
