include .env

.PHONY: up down stop prune ps shell drush logs restore composer

default: up

add-configs:
	@echo "Adding the configuration files for $(PROJECT_NAME)..."
	cp env/settings.php docroot/sites/default/settings.php
	cp env/settings.local.php docroot/sites/default/settings.local.php
	cp env/local.services.yml docroot/sites/default/local.services.yml
	@echo "Creatting the files folder and the config sync folder..."
	mkdir -p docroot/sites/default/files
	mkdir -p config/sync
	@echo "Updating the permissions for the settings file and files folder..."
	chmod 777 docroot/sites/default/files
	chmod 777 docroot/sites/default/settings.php

update-theme:
	@echo "Copying the theme folder $(PROJECT_NAME)..."
	rm -R -f docroot/themes/custom/lifecuisine
	mkdir -p docroot/themes/custom
	cp -R lifecuisine/ docroot/themes/custom/lifecuisine/

build:
	@echo "Copying the theme folder $(PROJECT_NAME)... to be deployed"
	rm -R lifecuisine/
	cp -R docroot/themes/custom/lifecuisine/ lifecuisine/

up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose up -d --remove-orphans

down: stop

stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop

clean:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose down -v

in:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_php' --format "{{ .ID }}") sh

in-apache:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_apache' --format "{{ .ID }}") sh

logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))
