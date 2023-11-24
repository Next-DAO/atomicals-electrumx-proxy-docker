# Atomicals RPC Server

Aim to provide a simple and easy way to run [atomicals-electrumx-proxy](https://github.com/atomicals/electrumx-proxy) server with [atomicals-electrumx](https://github.com/atomicals/atomicals-electrumx) service.

[中文说明](https://github.com/Next-DAO/atomicals-electrumx-proxy-docker/blob/main/README.zh-CN.md)

## Requirements

### 1. Bitcoin Full Node with `txindex=1` and enable rpc. A example of `bitcoin.conf`:

```ini
server=1
txindex=1

# genearate with [rpcauth.py](https://github.com/bitcoin/bitcoin/blob/master/share/rpcauth/rpcauth.py)
# equals to `rpcuser=nextdao` and `rpcpassword=nextdao`
rpcauth=nextdao:cca838b4b19bdc6093f4e0312550361c$213834a29e8488804946c196781059a7ee0ac2b48dbf896b4c6852060d9d83dd

rpcallowip=127.0.0.1
rpcallowip=172.0.0.0/8
rpcallowip=192.168.0.0/16

rpcbind=0.0.0.0
```

### 2. Install Docker with docker-compose.

## Usage

### 1. Download [docker-compose.yml](https://github.com/Next-DAO/atomicals-electrumx-proxy-docker/raw/main/docker-compose.yml) to a folder.

The folder's Disk should have at least **100G** spaces.

Edit `${IP:?}` in `docker-compose.yml` to your computer's ip address.

### 2. Run the RPC server:

```bash
docker-compose pull && docker-compose up -d
```

- the electrumx indexes stored in `./electrumx-data` directory.
- use `docker-compose logs -f` to check the logs.
- use `docker-compose down` to stop the server.

### 3. Used in [atomicals-js](https://github.com/atomicals/atomicals-js)

Edit .env with `ELECTRUMX_PROXY_BASE_URL=http://localhost:8080/proxy`, then use all commands as usual.

If you run atomicals cli in anthoer host, change `localhost` to the `ip` of the `proxy` server.

## FAQ

### 1. How to check if the server is ready?

```bash
docker-compose ps
```

If you see `electrumx` is `healthy`, then the server is ready.

### 2. Why `electrumx` can't connect to `bitcoind`?

Double check your `bitcoin.conf` and `docker-compose.yml`.

1. If your `ip` included in `rpcallowip` of `bitcoin.conf`?
2. If `bitcoind` listen on `8332` port?
3. If `bitcoind` rpc username and password is correct?

### 3. Why the sync is so slow?

One guess is your disk is slow. You can try to use a SSD disk.

I can't find any other reason. If you know, please tell me.

Or you can download the `electrumx-data`:

```
magnet:?xt=urn:btih:7KW5OXSWUQ2EFF57URE42GBRL2XCN5AI&dn=ElectrumX-Data-20231114
```

When your download is finished:

1. Stop the server: `docker-compose down` if it is running.
2. Delete `electrumx-data` directory in the folder which contains `docker-compose.yml`.
3. Unzip (use [7zip](https://www.7-zip.org/)) zip files in `ElectrumX-Data-20231114`, you will get a `electrumx-data` directory.
4. Move `electrumx-data` to the folder which contains `docker-compose.yml`.
5. Start the server: `docker-compose up -d`.
