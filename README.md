## About

This is a Docker image for [Tautulli](https://github.com/Tautulli/Tautulli) - the Python based monitoring and tracking tool for Plex Media Server.

The Docker image currently supports:

* running Tautulli under its __own user__ (not `root`)
* changing of the __UID and GID__ for the Tautulli user
* support for OpenSSL / HTTPS encryption

## Run

### Run via Docker CLI client

To run the Tautulli container you can execute:

```bash
docker run --name tautulli -v <datadir path>:/datadir -p 8181:8181 dbarton/tautulli
```

Open a browser and point it to [http://my-docker-host:8181](http://my-docker-host:8181)

### Run via Docker Compose

You can also run the Tautulli container by using [Docker Compose](https://www.docker.com/docker-compose).

If you've cloned the [git repository](https://github.com/domibarton/docker-tautulli) you can build and run the Docker container locally (without the Docker Hub):

```bash
docker-compose up -d
```

If you want to use the Docker Hub image within your existing Docker Compose file you can use the following YAML snippet:

```yaml
tautulli:
    image: "dbarton/tautulli"
    container_name: "tautulli"
    volumes:
        - "<datadir path>:/datadir"
    ports:
        - "8181:8181"
    restart: always
```

## Configuration

### Volumes

Please mount the following volumes inside your Tautulli container:

* `/datadir`: Holds all the Tautulli data files (e.g. config, database)

You might also want to mount the `Logs` directory of your Plex server into the container, in case you want to have access to the logs.

### Configuration file

By default the Tautulli configuration is located on `/datadir/config.ini`.
If you want to change this you've to set the `CONFIG` environment variable, for example:

```
CONFIG=/datadir/tautulli.ini
```

### UID and GID

By default Tautulli runs with user ID and group ID `666`.
If you want to run Tautulli with different ID's you've to set the `TAUTULLI_UID` and/or `TAUTULLI_GID` environment variables, for example:

```
TAUTULLI_UID=1234
TAUTULLI_GID=1234
```
