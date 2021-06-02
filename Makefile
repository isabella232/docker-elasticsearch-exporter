IMAGE := 107025123061.dkr.ecr.us-west-1.amazonaws.com/elasticsearch-exporter
TAG := $(shell date -u +%Y%m%d.%H%M%S)

.PHONY: default
default: push
	@printf "${IMAGE}:${TAG} ready\n"

.PHONY: push
push: build
	docker push ${IMAGE}:${TAG}

.PHONY: build
build:
	docker build -t ${IMAGE}:${TAG} .
