# Alpine based Prometheus Docker image for Raspberry Pi

## Pull image from Docker Hub
You can get the image from Docker Hub too:
```sh
docker pull ursweiss/prometheus-alpine-arm32v7
```

## Run
Three volumes are used to store persistent data:
* Database (prometheus-storage)
* Config (prometheus-etc)

```sh
docker volume create prometheus-storage
docker volume create prometheus-etc
```

Run the container:
```sh
docker run \
  -d \
  -it \
  -p 9090:9090 \
  --name=prometheus \
  --mount type=volume,src=prometheus-storage,dst=/prometheus,volume-driver=local \
  --mount type=volume,src=prometheus-etc,dst=/etc/prometheus,volume-driver=local,readonly \
  ursweiss/prometheus-alpine-marm32v7
```
