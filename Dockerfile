FROM openjdk:17 AS build
WORKDIR /example-clean-architecture
COPY build.gradle gradlew ./
COPY gradle ./gradle
COPY main.gradle .
RUN ./gradlew --version
RUN ./gradlew --no-daemon
COPY . .
RUN ./gradlew build --no-daemon --refresh-dependencies --stacktrace

FROM openjdk:17
WORKDIR /applications
COPY --from=build /example-clean-architecture/applications/app-service/build/libs/example-clean-architecture.jar ./
ENV MONGODB_URI="mongodb+srv://mdyagual:mdyagual@clustersofkau.hcyyx.mongodb.net/books-sofka-api?retryWrites=true&w=majority"
EXPOSE 8000
CMD ["java", "-jar", "example-clean-architecture.jar"]
