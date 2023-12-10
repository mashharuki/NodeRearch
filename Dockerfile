# syntax=docker/dockerfile:1
FROM --platform=${BUILDPLATFORM} golang:1.21.5 as BUILDER
RUN apt update && apt install -y build-essential git
WORKDIR /geth
ARG VERSION=v1.13.5
RUN git clone --quiet --branch ${VERSION} --depth 1 https://github.com/ethereum/go-ethereum .
RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build go run build/ci.go install -static ./cmd/geth

FROM --platform=${BUILDPLATFORM} gcr.io/distroless/base-debian12:latest
COPY --from=BUILDER /geth/build/bin/geth /usr/local/bin/
EXPOSE 8545 8546 8551 30303 30303/udp
USER 65532
ENTRYPOINT ["geth"]