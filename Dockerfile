# - set parent image
FROM openjdk:8-alpine

# - version PMD to download
ARG PMD_VERSION=6.35.0

# - get latest list of available packages and update
RUN apk update && apk upgrade

# - install wget package, --no-cache for smaller container
RUN apk add --no-cache wget

# - in case to avoid problems with starting .sh scripts
RUN apk add --no-cache --upgrade bash

# - create directory with no error if exists
RUN mkdir -p /opt/bin

# - get PMD from pmd.github.io
RUN cd /opt/bin \
    && wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip \
    && unzip pmd-bin-${PMD_VERSION}.zip \
    && rm -f pmd-bin-${PMD_VERSION}.zip \
    && mv pmd-bin-${PMD_VERSION} pmd

# - get our shell script from host
COPY pmd /usr/bin/pmd

# - get this file permission or it won't start
RUN chmod +x /opt/bin/pmd
RUN chmod +x /usr/bin/pmd


# - where we will put our github repo
# - if it doesn't exist it'll be created
WORKDIR /usr/src

# - start container with
CMD ["pmd"]
