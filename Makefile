SHELL := /bin/bash

DOCKER_COMPOSE := docker compose
ENV_FILE ?= .env.docker

APP_PORT ?= 8085
DB_HOST_PORT ?= 5434
DB_USERNAME ?= agent
DB_DATABASE ?= laravel-runtime-dev

.PHONY: up down restart logs ps build app-shell artisan db-shell

up:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) up -d
	@echo ""
	@echo "Application is available at: http://localhost:$(APP_PORT)"
	@echo "Postgres is available at: localhost:$(DB_HOST_PORT)"

down:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) down

restart: down up

logs:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) logs -f

ps:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) ps

build:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) build

app-shell:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) exec app bash

artisan:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) exec app php artisan $(cmd)

db-shell:
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) exec postgres psql -U $(DB_USERNAME) -d $(DB_DATABASE)

