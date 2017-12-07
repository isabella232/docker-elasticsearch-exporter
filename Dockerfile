FROM quay.io/prometheus/golang-builder as builder

RUN git clone https://github.com/justwatchcom/elasticsearch_exporter.git /go/src/github.com/justwatchcom/elasticsearch_exporter \
    && cd /go/src/github.com/justwatchcom/elasticsearch_exporter && git checkout tags/v1.0.2rc2

WORKDIR /go/src/github.com/justwatchcom/elasticsearch_exporter

RUN make

# https://github.com/justwatchcom/elasticsearch_exporter provides a Docker image built
# using `quay.io/prometheus/busybox:latest` but for some reason doesn't work. Therefore,
# we're building our own image
FROM prom/busybox:latest

COPY --from=builder /go/src/github.com/justwatchcom/elasticsearch_exporter/elasticsearch_exporter /bin/elasticsearch_exporter

EXPOSE 9108
ENTRYPOINT [ "/bin/elasticsearch_exporter" ]
