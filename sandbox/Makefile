HERE  := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGE := sandbox
TAG   := dev
NAME  := $(IMAGE)_$(TAG)

.PHONY: build attach clean cleani cleanc cleant

build:
	docker build -t $(IMAGE):$(TAG) $(HERE)

attach: cleanc
	docker run -it --name=$(NAME) --workdir /root $(IMAGE):$(TAG) /usr/sbin/zsh

clean: cleanc cleani

cleani:
	-docker rmi $(shell docker images -q $(IMAGE))
	-docker image prune -f

cleanc:
	-docker container prune -f

cleant:
	-docker rmi $(IMAGE):$(TAG)

echo:
	@echo $(HERE)
