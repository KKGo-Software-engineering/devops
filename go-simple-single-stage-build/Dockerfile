FROM golang:1.19-alpine

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o ./out/go-sample .

CMD ["/app/out/go-sample"]
