FROM golang:1-alpine3.12 AS builder
RUN apk -v --no-progress --no-cache add --upgrade curl git make
RUN git clone https://github.com/prometheus-community/elasticsearch_exporter /go/src/github.com/prometheus-community/elasticsearch_exporter \
 && cd /go/src/github.com/prometheus-community/elasticsearch_exporter \
 && git checkout 98c769b353cb \
 && make build

FROM prom/busybox:latest
COPY --from=builder /go/src/github.com/prometheus-community/elasticsearch_exporter/elasticsearch_exporter /bin/elasticsearch_exporter
EXPOSE 9108
ENTRYPOINT [ "/bin/elasticsearch_exporter" ]
