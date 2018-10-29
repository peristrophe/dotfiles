HERE  := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGE := sandbox
TAG   := dev
NAME  := $(IMAGE)_$(TAG)

.PHONY: build attach clean cleani cleanc cleant

build:
	docker build -t $(IMAGE):$(TAG) $(HERE)

attach: cleanc
	docker run -it --name=$(NAME) --workdir /root $(IMAGE):$(TAG) /usr/sbin/zsh

clean: cleani cleanc

cleani:
	-docker rmi $(shell docker images -q $(IMAGE))

cleanc:
	-docker rm -f $(NAME)

cleant:
	-docker rmi $(IMAGE):$(TAG)

echo:
	@echo $(HERE)
