# docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD:/data" shuaibmunshi/resume
FROM debian:bullseye-slim as installer
ARG DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get --no-install-recommends install -y \
        perl-modules \
        liburi-encode-perl \
        gnupg \
        ca-certificates \
        libfontconfig \
        wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

COPY texlive.profile /install/texlive.profile 

RUN mkdir /install; \
    cd /install; \
    wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xzf- --strip-components=1 && \
    ./install-tl -profile texlive.profile && \
    rm -r /install

ENV HOME=/tmp PATH="/usr/local/texlive/2021/bin/x86_64-linux:$PATH"

RUN tlmgr update --self

RUN tlmgr install \
        xcolor \
        datetime \
        geometry \
        hyperref \
        pdftexcmds \
        infwarerr \
        kvoptions \
        textpos \
        isodate \
        substr \
        titlesec \
        # collection-latex \
        # collection-luatex \
        collection-xetex \
        collection-fontsrecommended \
        fontspec && \
    rm -rf /usr/local/texlive/texmf-var/*

WORKDIR /data
VOLUME ["/data"]
# ENTRYPOINT [ "xetex resume.tex" ]
