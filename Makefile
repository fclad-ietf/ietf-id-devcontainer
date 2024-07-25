DCCMD = devcontainer
DCBUILD = $(DCCMD) build

IMAGE_REGISTRY = ghcr.io/fclad-ietf
IMAGE_NAME = ietf-id-devcontainer
IMAGE_VERSION ?= latest

.PHONY: all build push

all: build

build:
	$(DCBUILD) --workspace-folder src --image-name $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION)

push:
	$(DCBUILD) --workspace-folder src --push true --image-name $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION)
