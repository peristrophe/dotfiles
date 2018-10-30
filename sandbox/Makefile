HERE     := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGE    := sandbox
TAG      := dev
NAME     := $(IMAGE)_$(TAG)
USERNAME := app

.PHONY: build attach clean cleani cleanc cleant

build:
	docker build --build-arg username=$(USERNAME) --squash -t $(IMAGE):$(TAG) $(HERE)

attach:
	docker run --rm -it $(IMAGE):$(TAG) $(shell docker run --rm -it $(IMAGE):$(TAG) which zsh)

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
