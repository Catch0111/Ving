FROM node:10.15.3 as NODE_BUILD
WORKDIR /go/src/github.com/Movieserver/
ADD . /go/src/github.com/Movieserver/
RUN cd console && npm install && npm run build && cd ../theme && npm install && npm run build && \
    rm -rf node_modules && cd ../console && rm -rf node_modules

FROM golang:alpine as GO_BUILD
WORKDIR /go/src/github.com/Movieserver/
COPY --from=NODE_BUILD /go/src/github.com/Movieserver/ /go/src/github.com/Movieserver/
ENV GO111MODULE=on
RUN apk add --no-cache gcc musl-dev git && go build -i -v

FROM alpine:latest
LABEL maintainer="MovieServer XX"
WORKDIR /opt/server/
COPY --from=GO_BUILD /go/src/github.com/Movieserver/ /opt/server/
RUN apk add --no-cache ca-certificates tzdata

ENV TZ=Asia/Shanghai
EXPOSE 5897

ENTRYPOINT [ "/opt/pipe/server" ]
