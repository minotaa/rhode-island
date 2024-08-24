FROM alpine:3.14 AS base

# Environment Variables
ENV GODOT_VERSION "4.3"
ENV GODOT_EXPORT_PRESET="Linux"

# Install Godot and dependencies
# Thanks https://github.com/GodotNuts/GodotServer-Docker/blob/0b0b9d4faf40f85e24065b484bb5003f9cd7d0be/auto-export/dockerfile
RUN apk update
RUN apk add --no-cache bash
RUN apk add --no-cache wget
RUN apk add --no-cache git

RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk
RUN apk add --allow-untrusted glibc-2.31-r0.apk

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot \
    && rm -f Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip

FROM base as build

# Export the .pck
COPY . /usr/src/game
RUN rm -rf /usr/src/game/.godot
RUN godot --headless --path /usr/src/game --import
RUN godot --headless --path /usr/src/game --export-pack ${GODOT_EXPORT_PRESET} /usr/share/game.pck

FROM base

# Pterodactyl thing
RUN adduser --disabled-password --home /home/container container

COPY --from=build /usr/share/game.pck /usr/share/game.pck

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container
CMD ["godot", "--main-pack", "/usr/share/game.pck", "--headless"]