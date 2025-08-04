# SPDX-License-Identifier: MIT-0

ALL_SCRIPTS:=./bin/* ./lib/*
SHELLCHECK_OPTS:='--enable=avoid-nullary-conditions --enable=deprecate-which --enable=quote-safe-variables --enable=require-variable-braces --enable=useless-use-of-cat'

.PHONY: default
default: help

.PHONY: clean
clean: ## Clean the repository
	@git clean -fx \
		./.tmp/

.PHONY: dev-env dev-img
dev-env: dev-img ## Run an ephemeral development environment container
	@docker run \
		-it \
		--rm \
		--workdir "/asdf-diffoci" \
		--mount "type=bind,source=$(shell pwd),target=/asdf-diffoci" \
		--name "asdf-diffoci-dev" \
		asdf-diffoci-dev-img

dev-img: ## Build a development environment image
	@docker build \
		--tag asdf-diffoci-dev-img \
		--file Containerfile.dev \
		.

.PHONY: format format-check
format: ## Format the source code
	@shfmt --simplify --write $(ALL_SCRIPTS)

format-check: ## Check the source code formatting
	@shfmt --simplify --diff $(ALL_SCRIPTS)

.PHONY: help
help: ## Show this help message
	@printf "Usage: make <command>\n\n"
	@printf "Commands:\n"
	@awk -F ':(.*)## ' '/^[a-zA-Z0-9%\\\/_.-]+:(.*)##/ { \
		printf "  \033[36m%-30s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)

.PHONY: lint lint-ci lint-container lint-sh
lint: lint-ci lint-container lint-sh ## Run lint-*

lint-ci: $(ASDF) ## Lint CI workflow files
	@SHELLCHECK_OPTS=$(SHELLCHECK_OPTS) \
		actionlint

lint-container: $(ASDF) ## Lint the Containerfile
	@hadolint Containerfile.dev

lint-sh: ## Lint .sh files
	@SHELLCHECK_OPTS=$(SHELLCHECK_OPTS) \
		shellcheck \
		$(ALL_SCRIPTS)

.PHONY: release
release: ## Release a new version
ifneq "$(shell git branch --show-current)" "main"
	@echo 'refusing to release, not on main branch'
	@echo 'first run: "git switch main"'
else ifeq "$v" ""
	@echo 'usage: "make release v=1.0.1"'
else
	@git tag "v$v"
	@git push origin "v$v"
endif

.PHONY: test-download test-install test-installation test-latest-stable test-list-all
test-download: ## Test the download script
ifeq "$(version)" ""
	@echo 'usage: "make test-download version=0.1.6"'
else
	@rm -rf \
		".tmp/download/diffoci"
	@( \
		ASDF_DOWNLOAD_PATH=".tmp/download" \
		ASDF_INSTALL_VERSION="$(version)" \
		./bin/download \
	)
endif

test-install: ## Test the install script
ifeq "$(version)" ""
	@echo 'usage: "make test-install version=0.1.6"'
else
	@rm -rf \
		".tmp/install/diffoci"
	@( \
		ASDF_DOWNLOAD_PATH=".tmp/download" \
		ASDF_INSTALL_PATH=".tmp/install" \
		ASDF_INSTALL_TYPE="version" \
		ASDF_INSTALL_VERSION="$(version)" \
		./bin/install \
	)
endif

test-installation: ## Test the installation
	@echo 'INSTALLED VERSION:'
	@echo '------------------'
	@.tmp/install/bin/diffoci --version
	@echo
	@echo 'HELP TEXT:'
	@echo '----------'
	@.tmp/install/bin/diffoci --help

test-latest-stable: ## Test the latest-stable scripts
	@./bin/latest-stable

test-list-all: ## Test the list-all script
	@./bin/list-all

.PHONY: verify
verify: format-check lint ## Verify project is in a good state
