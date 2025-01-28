# Reality

只有节点,没有任何日志记录.

不知道的时候都找不到，知道的时候，都看见了。

## 配置介绍

在 Xray 中，shortIds 是用于代理连接中的一种优化机制，特别是在 VLESS 协议的配置中。它的作用是为了减少 UUID（用户标识符）的长度，使配置更加简洁且易于管理。具体来说，shortIds 是 UUID 的压缩或简化版本，可以用来代替传统的 UUID，来标识客户端或服务器。

客户端 shortId 可为空。若不为空，可 0 到 f（0123456789abcdef），长度为 2 的倍数，长度上限为 16 。

- dest：目标服务器的地址和端口。
- privateKey：用于加密的私钥。
- serverNames：一个或多个服务器的域名，用于 SNI (Server Name Indication)。
- shortIds：这些是客户端的简短 ID，可以包含多个客户端标识符。
- xver：协议版本。


## 构建

```
git clone https://github.com/comeyna/reality
docker build -t xray:reality .
```

## docker-compose 

```
services:
  xray_reality:
    image: xray:reality
    container_name: xray_reality
    restart: always
    ports:
      - "40000:443"
```

## 配置信息

```bash
vless://3c94c054-dc6f-4132-9888-5c60b81414b3@ip:40000?encryption=none&flow=xtls-rprx-vision&security=reality&sni=www.apple.com&fp=chrome&pbk=mKj4w7jYOQNKYblmZxxAz8gcDxg36sxMw4XCsxbHczk&type=tcp&headerType=none#%E8%87%AA%E5%AE%9A%E4%B9%89
```

```bash
ip_value=$(ip -4 addr show eth0 | grep inet | awk '{ print $2 }' | cut -d/ -f1) && vless_url="vless://3c94c054-dc6f-4132-9888-5c60b81414b3@$ip_value:40000?encryption=none&flow=xtls-rprx-vision&security=reality&sni=www.apple.com&fp=chrome&pbk=mKj4w7jYOQNKYblmZxxAz8gcDxg36sxMw4XCsxbHczk&type=tcp&headerType=none#%E8%87%AA%E5%AE%9A%E4%B9%89" && echo $vless_url
```

## 修改配置

 生成 UUID 钥匙 私钥 修改掉 config.json 的值 

 修改后需要重启容器

```bash
docker exec -it xray_reality sh

UUID="$(/xray uuid)" && echo "UUID: $UUID"

/xray x25519 >/key && PRIVATEKEY=$(cat /key | grep "Private" | awk -F ': ' '{print $2}') && PUBLICKEY=$(cat /key | grep "Public" | awk -F ': ' '{print $2}') && echo "Private key: $PRIVATEKEY" && echo "Public key: $PUBLICKEY"
```

## 挂载文件 docker-compose

复制到当前文件夹

```
docker cp xray_reality:/config.json ./config.json
```

```
services:
  xray_reality:
    image: xray:reality
    container_name: xray_reality
    restart: always
    ports:
      - "40000:443"
    volumes:
      - ./config.json:/config.json
```

## 开启日志

```
  "log": {
    "loglevel": "error",
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log"
  }
```

## 遗留问题 

```
      "sniffing": {
        "enabled": false,
        "destOverride": [
          "http",
          "tls",
          "quic",
          "fakedns"
        ]
      }
```

## 转变

1.  放弃他人的配置文件，重新学习，放弃监控，看到自己的日志记录，所有的行为都在被记录在案，在打开下载、上传的记录，就是一身冷汗啊。


## 参考

https://github.com/wulabing/xray_docker

https://github.com/XTLS/REALITY

https://github.com/lxhao61/integrated-examples/tree/main

https://xtls.github.io/config/fakedns.html#fakednsobject
