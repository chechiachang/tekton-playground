FROM golang:1.14.2-alpine

WORKDIR /helloworld

ADD . /helloworld

RUN cd /helloworld && go build

EXPOSE 8080

ENTRYPOINT ./helloworld
