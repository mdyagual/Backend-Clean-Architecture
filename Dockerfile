FROM openjdk:17 AS build
WORKDIR /example-clean-architecture
COPY build.gradle gradlew ./
COPY gradle ./gradle
COPY main.gradle .
RUN ./gradlew --version
RUN ./gradlew --no-daemon
COPY . .
RUN ./gradlew build --no-daemon --refresh-dependencies

FROM openjdk:17
WORKDIR /applications
COPY --from=build /example-clean-architecture/applications/build/libs/books-api.jar ./
ENV MONGODB_URI="mongodb+srv://mdyagual:mdyagual@clustersofkau.hcyyx.mongodb.net/books-sofka-api?retryWrites=true&w=majority"
EXPOSE 8080
CMD ["java", "-jar", "books-api.jar"]