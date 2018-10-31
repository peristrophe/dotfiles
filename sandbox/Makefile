HERE     := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGE    := sandbox
TAG      := dev
HOST     := my-sandbox
NAME     := $(IMAGE)_$(TAG)
USERNAME := app

.PHONY: build active deactive attach start stop clean cleani cleanc cleant

build:
	docker build --build-arg username=$(USERNAME) --squash -t $(IMAGE):$(TAG) $(HERE)

#construct:
#	docker run --restart=always --name=$(NAME) -d -u root $(IMAGE):$(TAG)
#
#destruct: stop
#
#attach:
#	docker exec -it -u $(USERNAME) -w /home/$(USERNAME) $(NAME) $(shell docker run --rm -it $(IMAGE):$(TAG) which zsh)
#
#admin:
#	docker exec -it -u root -w /root $(NAME) $(shell docker run --rm -it $(IMAGE):$(TAG) which zsh)
#
#start:
#	docker start $(NAME)
#
#stop:
#	docker stop $(NAME)

enter:
	docker run --rm -it -u $(USERNAME) -h $(HOST) \
		-v $(HOME)/Projects:/home/$(USERNAME)/Projects \
		$(IMAGE):$(TAG) $(shell docker run --rm -it $(IMAGE):$(TAG) which zsh)

clean: cleanc cleani

cleani:
	-docker rmi $(shell docker images -q $(IMAGE))
	-docker image prune -f

cleanc:
	-docker rm -f $(NAME)
	-docker container prune -f

cleant:
	-docker rmi $(IMAGE):$(TAG)
