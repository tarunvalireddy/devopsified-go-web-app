FROM golang:1.22.5 as build

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main

#final stage

FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=build /app/main ./

COPY --from=build /app/static ./static

EXPOSE 8081

CMD ["./main"]
