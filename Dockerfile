# Builder
FROM golang:1.13.5-alpine3.10 as builder

RUN apk update && apk upgrade && \
    apk --update add git make

# Download and install the latest release of dep
ADD https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep

# Copy the code from the host and compile it
WORKDIR $GOPATH/src
run git clone https://github.com/nikhilbhide/golang-http

WORKDIR $GOPATH/src/golang-http/JWTDemo

COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app .

FROM scratch
COPY --from=builder /app ./
ENTRYPOINT ["./app"]