FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY main.go ./

RUN go build -o sre-go-web-app .

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/sre-go-web-app .

EXPOSE 8080

CMD ["./sre-go-web-app"]