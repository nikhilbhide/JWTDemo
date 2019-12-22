# Builder
FROM golang:1.12.1-alpine as builder

RUN apk update && apk upgrade && \
    apk --update add git make

# Download and install the latest release of dep
ADD https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep
RUN export PATH=$PATH:$GOPATH/bin
# Copy the code from the host and compile it
WORKDIR $GOPATH/src
run mkdir -p github.com
WORKDIR $GOPATH/src/github.com
run mkdir -p nikhilbhide
WORKDIR $GOPATH/src/github.com/nikhilbhide
run git clone https://github.com/nikhilbhide/JWTDemo
WORKDIR $GOPATH/src/github.com/nikhilbhide/JWTDemo

#COPY . ./
#RUN CGO_ENABLED=0 GOOS=linux godep go build -a -installsuffix nocgo -o /app .

#FROM scratch
#COPY --from=builder /app ./
#run godep save
run go build

ENTRYPOINT ["./JWTDemo"]