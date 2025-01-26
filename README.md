# Reality

手动操作，加深理解。

私有化之后，以后都可以一键使用。

## 构建

```
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
    logging:
      options:
        max-size: "10m"
        max-file: "3"
```

## 配置信息

```bash
vless://3c94c054-dc6f-4132-9888-5c60b81414b3@ip:40000?encryption=none&flow=xtls-rprx-vision&security=reality&sni=www.apple.com&fp=chrome&pbk=mKj4w7jYOQNKYblmZxxAz8gcDxg36sxMw4XCsxbHczk&type=tcp&headerType=none#%E8%87%AA%E5%AE%9A%E4%B9%89
```

## 修改配置

 生成 UUID 钥匙 私钥 修改掉 config.json 的值 

 修改后需要重启容器

```bash
docker exec -it xray_reality sh

UUID="$(/xray uuid)" && echo "UUID: $UUID"

/xray x25519 >/key && PRIVATEKEY=$(cat /key | grep "Private" | awk -F ': ' '{print $2}') && PUBLICKEY=$(cat /key | grep "Public" | awk -F ': ' '{print $2}') && echo "Private key: $PRIVATEKEY" && echo "Public key: $PUBLICKEY"
```

## 参考

https://github.com/wulabing/xray_docker
