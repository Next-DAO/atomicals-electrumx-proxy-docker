# Atomicals ElectrumX Proxy Docker

Aim to provide a simple and easy way to run [atomicals-electrumx-proxy](/atomicals/electrumx-proxy) server.


## Requirements

1. Bitcoin Full Node with `txindex=1` and enable rpc.
2. Docker with docker-compose.
3. At least **100G** left in your storage.

## Usage

### 1. Download [docker-compose.yml](/raw/main/docker-compose.yml) to a folder.

Create an `.env` file with content below (**change to your own settings**):

```ini
DAEMON_URL=rpcuser:rpcpassword@192.168.50.111:8332
```

2. Run the server:

```bash
docker-compose pull && docker-compose up -d
```

- use `docker-compose ps` to check if electrumx is ready.
- use `docker-compose logs -f` to check the logs.
- use `docker-compose down` to stop the server.

3. Used in [atomicals-js](/atomicals/atomicals-js)

Edit .env with `ELECTRUMX_PROXY_BASE_URL=http://localhost:8080/proxy`, then use all commands as usual.

If you run atomicals cli in anthoer host, change `localhost` to the `ip` of the `proxy` server.
