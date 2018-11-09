HERE      := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
REPOS     := sandbox
TAG       := dev
HOST      := my-sandbox
CONTAINER := $(REPOS)_$(TAG)
USERNAME  := app
VOLUMEDIR := Projects

.PHONY: build active deactive attach start stop clean cleani cleanc cleant

build:
	docker build --build-arg username=$(USERNAME) --squash -t $(REPOS):$(TAG) $(HERE)
	docker image prune -f

prepare:
ifeq (,$(shell find $(HOME) -maxdepth 1 -type d -name $(VOLUMEDIR)))
	mkdir $(HOME)/$(VOLUMEDIR)
endif
#construct:
#	docker run --restart=always --name=$(CONTAINER) -d -u root $(REPOS):$(TAG)
#
#destruct: stop
#
#attach:
#	docker exec -it -u $(USERNAME) -w /home/$(USERNAME) \
#		$(CONTAINER) $(shell docker run --rm -it $(REPOS):$(TAG) which zsh)
#
#admin:
#	docker exec -it -u root -w /root \
#		$(CONTAINER) $(shell docker run --rm -it $(REPOS):$(TAG) which zsh)
#
#start:
#	docker start $(CONTAINER)
#
#stop:
#	docker stop $(CONTAINER)

enter: prepare
	docker run --rm -it -u $(USERNAME) -h $(HOST) \
		-v $(HOME)/$(VOLUMEDIR):/home/$(USERNAME)/$(VOLUMEDIR) \
		$(REPOS):$(TAG) $(shell docker run --rm -it $(REPOS):$(TAG) which zsh)

clean: cleanc cleani

cleani:
	-docker rmi $(shell docker images -q $(REPOS))
	-docker image prune -f

cleanc:
	-docker rm -f $(CONTAINER)
	-docker container prune -f

cleant:
	-docker rmi $(REPOS):$(TAG)
