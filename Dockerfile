FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

LABEL maintainer="lanjelin"

ENV TITLE=Obsidian-Docker
ENV VERSION=1.6.2

# add local files
COPY /root /

RUN \
    sed -i 's|</applications>|  <application title="Obsidian-Docker" type="normal">\n    <maximized>no</maximized>\n  </application>\n</applications>|' /etc/xdg/openbox/rc.xml && \
  echo "**** update packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      wget && \
  echo "**** install Obsidian ****" && \
    wget https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/obsidian_${VERSION}_amd64.deb -O /tmp/obsidian.deb && \
    apt install -y /tmp/obsidian.deb && \
  echo "**** setting permissions ****" && \
    chmod 755 /defaults/autostart && \
  echo "**** cleanup ****" && \
    rm -rf \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/tmp/*

# ports and volumes
EXPOSE 3000 3001

WORKDIR /config/obsidian
VOLUME /config/obsidian
