FROM alpine

LABEL version="0.1"
LABEL author="Cybernick"
LABEL description="Parsoid docker image"

# Install required packages
RUN apk add --no-cache nodejs nodejs-npm python git tar bash make

ENV PARSOID_HOME=/var/lib/parsoid \
    PARSOID_USER=parsoid \
    PORT=8142

# Avaiable branch v0.9.0, v0.10.0. Master branch is by default.
ARG PARSOID_VERSION=master

# Parsoid setup
RUN set -x; \
    # Add user
    adduser -D -u 1000 -s /bin/bash $PARSOID_USER \
    # Core
    && mkdir -p $PARSOID_HOME \
    && git clone \
        --branch ${PARSOID_VERSION} \
        --single-branch \
        --depth 1 \
        --quiet \
        https://gerrit.wikimedia.org/r/p/mediawiki/services/parsoid \
        $PARSOID_HOME \
    && cd $PARSOID_HOME \
    && npm install

COPY run-parsoid.sh /run-parsoid.sh
RUN chmod -v +x /run-parsoid.sh

EXPOSE 8142
CMD ["/run-parsoid.sh"]