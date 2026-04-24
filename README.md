# PocketBase Docker Image

自动构建 [PocketBase](https://pocketbase.io/) 的 Docker 镜像，PocketBase 发布新版本时自动更新。

## 特性

- 基于精简的 Alpine 镜像
- 支持 `linux/amd64` + `linux/arm64` 双架构
- 每日自动检测新版本，有新版才触发构建
- 同时推送 `latest` 和版本号 tag（如 `0.23.0`）

## 使用

```bash
docker pull allenjia09/pocketbase:latest
```

### docker-compose

```yaml
services:
  pocketbase:
    image: allenjia09/pocketbase:latest
    ports:
      - "8090:8090"
    volumes:
      - pb_data:/pb/pb_data
    restart: unless-stopped

volumes:
  pb_data:
```

### 指定版本

```bash
docker pull allenjia09/pocketbase:0.23.0
```

### 手动构建（指定版本）

```bash
docker build --build-arg PB_VERSION=0.23.0 -t pocketbase .
```

不传 `PB_VERSION` 则自动获取最新版。

## 自动构建

通过 GitHub Actions 实现：

- 每日 UTC 02:00 自动检测 PocketBase 是否有新版本
- 有新版本时自动构建并推送到 DockerHub
- 支持手动触发（仓库 Actions 页 → Run workflow）

## 端口与数据

| 项目 | 值 |
|---|---|
| 默认端口 | 8090 |
| 数据目录 | `/pb/pb_data` |

## 相关

- [PocketBase 官网](https://pocketbase.io/)
- [PocketBase GitHub](https://github.com/pocketbase/pocketbase)
- [DockerHub 镜像](https://hub.docker.com/r/allenjia09/pocketbase)