# quarkus-getting-started

Result of the [quarkus.io getting started](https://quarkus.io/get-started/) - slightly extended so 

* a GraalVM native image can be built using a "self-contained" `Dockerfile` that does not require to build or install 
  anything locally and
* to be compiled statically so a minimal (`scratch`) docker base image can be used.

To build just run

```bash
docker build -t quarkus/getting-started .
```

Then start the container with

```
docker run -i --rm -p 8080:8080 quarkus/getting-started
```

## Base images compared

As of April 2019, the quarkus.io getting started uses the fedora image to pack the final image. 
This repo provides a couple of other base images that compare as follows

| Base Image | Size | Shell | Package Manager | libc | Basic Linux Folders | Static Binary | `Dockerfile` | 
|---|---|---|---|---| ---| ---| ---|
| fedora | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:fedora.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☒ | ☒ | ☒ | ☒ | ☐ | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/88a012521f667581c55d62873cbfa2d2313a5999/Dockerfile) | 
| debian | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:debian.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☒ | ☒ | ☒ | ☒ | ☐ | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/c2576a08c9f167cf1d42c3bf79d164e89e493664/Dockerfile) | 
| alpine-glibc | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:alpine-glibc.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☒ | ☒ | ☒ | ☒ | ☐ | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/03952fd4736a63593b6f0cf7ad7ed3e3c23e01f3/Dockerfile) | 
| distroless-base | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:distroless-base.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☐ | ☐ | ☒ | ☒ | ☒ | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/38f71f595ea4c41ce8f552f58737ae0ca8c3e5da/Dockerfile) |
| busybox | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:busybox.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☒ | ☐ | ☒ | ☒ | ☒  | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/cb5ed180715ab8557ed006498691827320d35761/Dockerfile) |
| distroless-static | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:distroless-static.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☐ | ☐ | ☐ | ☒ | ☒ | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/bbb7295f45260511630324cc753c00ae50182997/Dockerfile) |
| scratch | [![](https://images.microbadger.com/badges/image/schnatterer/quarkus-getting-started:scratch.svg)](https://hub.docker.com/r/schnatterer/quarkus-getting-started/tags) | ☐ | ☐ | ☐ | ☐ | ☒ | [📄](https://github.com/schnatterer/quarkus-getting-started/blob/2b63e8f102a449c230d42729aa4e20783dafa86e/Dockerfile) |

Note that 

* size is the compressed size within the DockerHub registry,
* if a shell is needed
    * distroless images offer a `debug` tag (e.g.) `gcr.io/distroless/base:debug` that includes a shell. That is, the 
      image can easily be built with a shell if necessary,
    * for `scratch` or in general at runtime you could just copy a statically compiled shell into the container, if 
      needed for debugging (except, of course, you're using a read-only filesystem):
  
```bash
docker run --rm --name quarkus-getting-started schnatterer/quarkus-getting-started

docker create --name busybox busybox
docker cp busybox:/bin/busybox busybox
docker cp busybox quarkus-getting-started:/busybox
docker exec -it quarkus-getting-started /busybox sh
```
