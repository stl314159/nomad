FROM debian:buster-slim AS build-base

ENV NOMAD_VERSION 0.12.5

RUN apt-get update -y \
    && apt-get install -y wget zip \
    && wget https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip \
    && unzip nomad_${NOMAD_VERSION}_linux_amd64.zip \
    && chmod +x /nomad

FROM debian:buster-slim
COPY --from=build-base /etc/ssl/certs/ /etc/ssl/certs
COPY --from=build-base /nomad /
ENTRYPOINT ["/nomad"]
