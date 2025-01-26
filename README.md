# Reality

全手动设置，加深理解。

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

默认，修改掉 自己的 UUID 钥匙 私钥 

## 参考

https://github.com/wulabing/xray_docker
