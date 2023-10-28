FROM node:20-alpine

ARG VERSION=master

ADD https://github.com/atomicals/electrumx-proxy/archive/${VERSION}.zip /tmp

RUN set -ex && \
    cd /tmp && unzip ${VERSION} && \
    mv /tmp/electrumx-proxy-${VERSION} /app

WORKDIR /app

RUN set -ex && \
    # install dependencies
    npm install

ENV PORT=8080
ENV ELECTRUMX_PORT=50001
ENV ELECTRUMX_HOST=127.0.0.1

EXPOSE 8080

ENTRYPOINT ["npm", "run", "start"]
