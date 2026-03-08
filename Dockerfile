# Stage 1: Build
FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o hello-world-app .

# Stage 2: Runtime
FROM alpine:3.19

RUN adduser -D -g '' appuser
WORKDIR /app
COPY --from=builder /app/hello-world-app .

USER appuser
EXPOSE 8080

ENTRYPOINT ["./hello-world-app"]
