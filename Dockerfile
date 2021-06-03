# - set parent image
FROM openjdk:8-alpine

# - image owner
LABEL maintainer="milapetrovsk@gmail.com"

# - get latest list of available packages and update
RUN apk update && apk upgrade

# - install wget package, --no-cache for smaller container
RUN apk add --no-cache wget

# - create directory with no error if exists
RUN mkdir -p /opt

# - get PMD from pmd.github.io
RUN cd /opt \
    && wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.35.0/pmd-bin-6.35.0.zip\
    && unzip pmd-bin-6.35.0.zip \
    && rm -f pmd-bin-6.35.0.zip \
    && mv pmd-bin-6.35.0 pmd


RUN mkdir /src
VOLUME /src # - deafault working directory
WORKDIR /src  # - provides working directory for instructions

# - start container with
CMD ["pmd"]
