#ifndef TAG
#$(error The TAG variable is missing.)
#endif

ifndef ENV
ENV := localhost
endif

ifndef TAG
TAG := latest
endif

#ifndef TAG
#$(error The TAG variable is missing.)
#endif

include $(ENV).env
.EXPORT_ALL_VARIABLES:
.DEFAULT_GOAL := help

REPOSITORY :=
IMAGE := butr-customer
SERVICES :=
COMPOSE_FILE_PATH := -f docker-compose.yml -f docker-compose.$(ENV).yml
APP_ENTRYPOINT_ARGS :=

ifeq ($(IMAGE),butr-customer)
# if using app image, reset entrypoint to get into app base image's default entry point
APP_ENTRYPOINT_ARGS :=--entrypoint=
endif

ifeq ($(ENV),com)
REPOSITORY := gcr.io/it-department-150323/
endif

ifeq ($(ENV),local)
REPOSITORY := gcr.io/it-department-150323/
endif

.PHONY: help
help:                           ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: update-config
update-config:                  ## Updates config stored in volume based on environment
	docker cp ./config/config_override.$(ENV).php butr-customer-app:/run/config/config_override.php

.PHONY: show-env
show-env:                       ## Show environmental variables
	@env

.PHONY: status
status:                         ## Show running containers and statuses
	@docker-compose ps

.PHONY: config
config:                         ## Show the config file for this app
	@docker-compose $(COMPOSE_FILE_PATH) config

.PHONY: build
build:                          ## Builds an environment (specified by the ENV env. variable) # --no-cache
	$(info Make: Building "$(ENV)" environment images.)
	@docker-compose $(COMPOSE_FILE_PATH) build --no-cache $(SERVICES)

.PHONY: refresh
refresh:                       ## Refreshes SERVICES
	$(info Make: Refreshing database)
	@make remove SERVICES=$(SERVICES)
	@make start SERVICES=$(SERVICES)

.PHONY: setup
setup:                          ## Sets up environment - does not start containers
	docker-compose $(COMPOSE_FILE_PATH) up --no-start $(SERVICES)

.PHONY: seed
seed:                           ## Places database seed into "seed" volume
	docker cp ./svc/mariadb/init/. butr-customer-database:/docker-entrypoint-initdb.d/

.PHONY: tag
tag:                            ## Tags this image across all repositories (IMAGE and TAG env. variables)
	$(info Make: Tagging aliases of "$(IMAGE):$(TAG)" images.)
	$(info Make: Alias $(REPOSITORY)$(IMAGE):$(TAG))
	@docker tag $(IMAGE):$(TAG) $(REPOSITORY)$(IMAGE):$(TAG)

.PHONY: remote-tag
remote-tag:                     ## Associate remote image to local image
	$(info Make: Tagging aliases of "$(REPOSITORY)$(IMAGE):$(TAG)" images.)
	$(info Make: Alias $(IMAGE):$(TAG))
	@docker tag $(REPOSITORY)$(IMAGE):$(TAG) $(IMAGE):$(TAG)

.PHONY: release
release: build tag push         ## Builds, tags, and pushes

.PHONY: up
up:                             ## Brings up containers (specified by ENV env. variable)
	$(info Make: Starting "$(ENV)" environment containers.)
	docker-compose $(COMPOSE_FILE_PATH) up $(SERVICES)

.PHONY: start
start:                          ## Starts the containers in the background
	$(info Make: Starting "$(ENV)" environment containers.)
	docker-compose $(COMPOSE_FILE_PATH) up -d $(SERVICES)

.PHONY: into
into:                           ## Interactive CLI of a running service
	@docker exec -it $(SERVICES) /bin/bash

.PHONY: run
run:                            ## Interactive CLI of application
	@docker run -it $(APP_ENTRYPOINT_ARGS) --rm $(IMAGE):$(TAG) /bin/bash

.PHONY: runsvc
runsvc:
	@docker-compose $(COMPOSE_FILE_PATH) run $(APP_ENTRYPOINT_ARGS) --rm --no-deps $(SERVICES) /bin/bash
.PHONY: runsvcp
runsvcp:
	@docker-compose $(COMPOSE_FILE_PATH) run $(APP_ENTRYPOINT_ARGS) --service-ports --rm $(SERVICES) sh

.PHONY: rundev
rundev:
	@docker run -it $(APP_ENTRYPOINT_ARGS) --rm $(IMAGE):$(TAG) /bin/bash

.PHONY: stop
stop:                           ## Stop any running containers
	$(info Make: Stopping containers.)
	@docker-compose $(COMPOSE_FILE_PATH) stop $(SERVICES)

.PHONY: restart
restart: stop start             ## Stops if running, starts

.PHONY: remove
remove:                         ## Removes all associated resources
	@docker-compose $(COMPOSE_FILE_PATH) rm -s -v $(SERVICES)

.PHONY: push
push:                           ## Pushes application images to any remote repositories
	$(info Make: Pushing "$(TAG)" tagged image.)
#    ifeq ($(filter $(ENV),localhost),)
#    $(error The ENV variable is invalid.)
#    endif
	@docker push $(REPOSITORY)$(IMAGE):$(TAG)

.PHONY: pull
pull:                           ## Pulls the specified image by IMAGE and TAG env variables
	$(info Make: Pulling "$(TAG)" tagged image.)
	@docker pull $(REPOSITORY)$(IMAGE):$(TAG)

.PHONY: clean
clean:                          ## Cleans the entire docker system
	@docker system prune --volumes --force

.PHONY: login-dh
login-dh:                       ## Login to docker hub (DOCKER_USER and DOCKER_PASS env var)
	$(info Make: Login to Docker Hub.)
	@docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)

.PHONY: conf-gc
conf-gc:                        ## Sets up Google Cloud authentication for Google Cloud Container repositories
	@gcloud auth configure-docker