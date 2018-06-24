# Alpine based Prometheus Docker image for Raspberry Pi

## Pull image from Docker Hub
You can get the image from Docker Hub too:
```sh
docker pull ursweiss/prometheus-alpine-arm32v7
```

## Run
Three volumes are used to store persistent data:
* Database & Config (prometheus-storage)

```sh
docker volume create prometheus-storage
```

Run the container:
```sh
docker run \
  -d \
  -it \
  -p 9090:9090 \
  --name=prometheus \
  --mount type=volume,src=prometheus-storage,dst=/prometheus,volume-driver=local \
  ursweiss/prometheus-alpine-marm32v7
```
