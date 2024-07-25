DCCMD = devcontainer
DCBUILD = $(DCCMD) build

IMAGE_REGISTRY = ghcr.io/fclad-ietf
IMAGE_NAME = ietf-id-devcontainer
IMAGE_VERSION ?= latest

.PHONY: all build push clean cleanall

all: build

build:
	$(DCBUILD) --workspace-folder src --image-name $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION)

push:
	$(DCBUILD) --workspace-folder src --push true --image-name $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION)

clean:
	docker builder prune -f

cleanall:
	docker rmi -f $$(docker images --filter=reference='$(IMAGE_REGISTRY)/$(IMAGE_NAME)' -q)
	docker builder prune -af
