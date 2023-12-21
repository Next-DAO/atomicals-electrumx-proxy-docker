# Atomicals RPC 节点

提供简单的方法来运行 Atomicals RPC 节点，使用了 [electrumx-proxy](https://github.com/atomicals/electrumx-proxy) 和 [atomicals-electrumx](https://github.com/atomicals/atomicals-electrumx)。


## 安装要求

### 1. 开启了 `txindex=1` 和 RPC 功能的 BTC 全节点，配置示例：

```ini
server=1
txindex=1

# 用 [rpcauth.py](https://github.com/bitcoin/bitcoin/blob/master/share/rpcauth/rpcauth.py) 生成
# 相当于 `rpcuser=nextdao` 和 `rpcpassword=nextdao`
rpcauth=nextdao:cca838b4b19bdc6093f4e0312550361c$213834a29e8488804946c196781059a7ee0ac2b48dbf896b4c6852060d9d83dd

rpcallowip=127.0.0.1
# 允许容器网络 ip, 包含 172.0.0.1 - 172.254.254.254
rpcallowip=172.0.0.0/8
# 允许本地局域网 ip, 包含 192.168.0.1 - 192.168.254.254
rpcallowip=192.168.0.0/16

# 允许公网 ip，网线直接插电脑，无路由器的情况下使用
# rpcallowip=xxx.xxx.xxx.xxx/32

# 本地所有 ip 监听 8332 端口
rpcbind=0.0.0.0
```

### 2. 安装 Docker 和 docker-compose

一般情况下，Mac 和 Windows 用户安装 Docker 时会自动安装 docker-compose。

对 Linux 用户来说，需要单独安装 docker-compose。

## 使用方法

### 1. 下载 [docker-compose.yml](https://github.com/Next-DAO/atomicals-electrumx-proxy-docker/raw/main/docker-compose.yml)

放到一个磁盘剩余空间至少 **100G** 的目录下。

修改 `docker-compose.yml` 中的 `${IP:?}` 部分为你的电脑的局域网 ip `192.168.xxx.xxx` 或者公网 ip。

### 2. 运行 RPC 服务

```bash
docker-compose pull && docker-compose up -d
```

- 同步的索引文件存放在 `electrumx-data` 目录里。
- 使用 `docker-compose logs -f` 查看 log。
- 使用 `docker-compose down` 停止并删除容器，不影响索引文件。

### 3. 在 [atomicals-js](https://github.com/atomicals/atomicals-js) 中使用

编辑 .env, 加入一行

```
ELECTRUMX_PROXY_BASE_URL=http://localhost:8080/proxy
```

并在原先的 `ELECTRUMX_PROXY_BASE_URL` 之前加上 `#` 注释，然后就可以和之前一样使用所有命令。

如果你在另外一台电脑上运行 atomicals cli，将 `localhost` 改为当前电脑的 ip。

## FAQ

### 1. 怎么判断服务是否已经启动？

```bash
docker-compose ps
```

如果你看到 `electrumx` 显示 `healthy`，表示服务已经启动。

### 2. 为什么看到 `electrumx` 不能连接到 `bitcoind`?

请反复确认 `bitcoin.conf` 和 `docker-compose.yml`.

1. 你电脑的 ip 是否包含在 `bitcoin.conf` 的 `rpcallowip` 里
2. `bitcoind` 是否监听了 `8332` 端口
3. `bitcoind` 的 rpc 用户名和密码是否正确

### 3. 为什么同步这么慢？

一个猜测是硬盘速度太慢，可以尝试使用 SSD 硬盘。

我也没找到其他原因，如果你知道，请告诉我。

因为 v1.3.6 版本修改了 leveldb 结构，所以需要从头同步。因此删除了无用磁力链接。

~~或者你可以下载同步好的  `electrumx-data`:~~

~~当你下载完之后~~
~~1. 如果你已经在运行了，执行 `docker-compose down` 停止服务。~~
~~2. 删除 `docker-compose.yml` 所在目录下的 `electrumx-data` 目录。~~
~~3. 解压 (使用 (7zip)[https://www.7-zip.org/]) `ElectrumX-Data-20231114` 里的 zip 文件，得到 `electrumx-data` 目录。~~
~~4. 将 `electrumx-data` 移动到 `docker-compose.yml` 所在目录。~~
~~5. 重新启动服务 `docker-compose up -d`。~~
~~6. 大概 30 分钟后，可以提供服务。 ( 4 核 8G 内存运行 Linux 的电脑上测试)~~
