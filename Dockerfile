# builder
FROM golang:alpine AS builder
LABEL version="Xray 25.1.1"


WORKDIR /app

RUN apk add --no-cache git curl jq && \ 
    LATEST_VERSION_TAG=$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | jq -r '.[0].tag_name') && \
    git clone https://github.com/XTLS/Xray-core.git . && \
    git checkout $LATEST_VERSION_TAG && \
    go mod download && \
    go build -o xray /app/main/

# runner
FROM alpine:latest AS runner

ENV TZ=Asia/Shanghai

WORKDIR /

COPY ./config.json /
COPY ./key /


COPY --from=builder /app/xray /

RUN apk add --no-cache tzdata ca-certificates jq curl libqrencode-tools && \
    mkdir -p /var/log/xray &&\
    wget -O /geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat && \
    chmod +x /entrypoint.sh

# 设置 Xray 运行命令
ENTRYPOINT ["/xray", "-config", "/config.json"]

EXPOSE 443
