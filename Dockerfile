FROM alpine:3.14 AS build

# Environment Variables
ENV GODOT_VERSION "4.3"
ENV GODOT_EXPORT_PRESET="Linux"

# Install Godot and dependencies + export template
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
    && mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable \
    && unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable \
    && rm -f Godot_v${GODOT_VERSION}-stable_export_templates.tpz Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip

# Export the .pck
COPY . /usr/src/game
RUN rm -rf /usr/src/game/.godot
RUN godot --headless --path /usr/src/game --import
RUN godot --headless --path /usr/src/game --export-release ${GODOT_EXPORT_PRESET} /usr/bin/game

FROM alpine:3.14

# Environment Variables
ENV GODOT_VERSION "4.3"

# Install Godot and dependencies
RUN apk update
RUN apk add --no-cache bash
RUN apk add --no-cache wget
RUN apk add --no-cache git

RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk
RUN apk add --allow-untrusted glibc-2.31-r0.apk

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot \
    && rm -f Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip

# Pterodactyl thing
RUN adduser --disabled-password --home /home/container container

COPY --from=build /usr/bin/game /usr/bin/game

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container
CMD ["/usr/bin/game", "--headless"]