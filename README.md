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

## 参考

https://github.com/wulabing/xray_docker
