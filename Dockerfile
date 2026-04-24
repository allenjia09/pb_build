FROM alpine:latest AS downloader

ARG PB_VERSION="latest"

RUN apk add --no-cache curl unzip jq

RUN if [ "$PB_VERSION" = "latest" ]; then \
      PB_VERSION=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest | jq -r '.tag_name' | sed 's/^v//'); \
    fi && \
    echo "Building PocketBase version: ${PB_VERSION}" && \
    curl -L -o /tmp/pocketbase.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip" && \
    unzip /tmp/pocketbase.zip -d /tmp/pb/

FROM alpine:latest

RUN apk add --no-cache \
    ca-certificates \
    tzdata \
    openssl

WORKDIR /pb

COPY --from=downloader /tmp/pb/pocketbase /pb/pocketbase

RUN chmod +x /pb/pocketbase

VOLUME /pb/pb_data

EXPOSE 8090

CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]