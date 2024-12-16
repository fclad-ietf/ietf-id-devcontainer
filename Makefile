DCCMD = devcontainer
DCBUILD = $(DCCMD) build

IMAGE_REGISTRY = ghcr.io/fclad-ietf
IMAGE_NAME = ietf-id-devcontainer
IMAGE_VERSION ?= latest

# Obtain local build platform (for dev) and define the list of target platforms
UNAME := $(shell uname -m)
LOCAL_PLATFORM := linux/amd64
ifneq ($(filter $(UNAME),arm64 aarch64),)
        LOCAL_PLATFORM = linux/arm64/v8
endif
ALL_PLATFORMS ?= linux/amd64,linux/arm64/v8

.PHONY: all build push clean cleanall

all: build

build:
	$(DCBUILD) --platform $(LOCAL_PLATFORM) --workspace-folder src --image-name $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION)

push:
	$(DCBUILD) --platform $(ALL_PLATFORMS) --workspace-folder src --push true --image-name $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION)

clean:
	docker builder prune -f

cleanall:
	docker rmi -f $$(docker images --filter=reference='$(IMAGE_REGISTRY)/$(IMAGE_NAME)' -q)
	docker builder prune -af
