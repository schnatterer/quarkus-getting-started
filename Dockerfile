####
# This Dockerfile is used in order to build a container that runs the Quarkus application in native (no JVM) mode
#
# Build the image with:
#
# docker build -f src/main/docker/Dockerfile.native -t quarkus/getting-started .
#
# Then run the container using:
#
# docker run -i --rm -p 8080:8080 quarkus/getting-started
#
###

FROM maven:3.6.0-jdk-8-alpine as mavencache
ENV MAVEN_OPTS=-Dmaven.repo.local=/mvn
COPY pom.xml /mvn/
WORKDIR /mvn
RUN mvn test-compile dependency:resolve dependency:resolve-plugins


FROM oracle/graalvm-ce:1.0.0-rc16 AS native-image
ENV MAVEN_OPTS=-Dmaven.repo.local=/mvn
COPY --from=mavencache /mvn/ /mvn/
RUN mkdir /app
COPY . /app
WORKDIR /app

# Build native image
ENV GRAALVM_HOME=/usr
RUN ./mvnw package -Pnative

# Prepare everything for final image
RUN mkdir -p /dist/work
RUN cp /app/target/*-runner /dist/work/application
RUN chmod 775 /dist/work


FROM gcr.io/distroless/base

WORKDIR /work/
COPY --from=native-image /dist /
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]