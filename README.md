# quarkus-getting-started

Result of the [quarkus.io getting started](https://quarkus.io/get-started/) - slightly extended so a GraalVM native 
image can be built using a "self-contained" `Dockerfile` that does not require to build or install anything locally.

To build just run

```bash
docker build -t quarkus/getting-started .
```

Then start the container with

```
docker run -i --rm -p 8080:8080 quarkus/getting-started
```