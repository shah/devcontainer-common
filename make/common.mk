# Common makefile configuration and targets by Shahid N. Shah
# For advice:
# * [Your Makefiles are wrong](https://tech.davis-hansson.com/p/make/)

SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS := silent
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq (Windows_NT,$(OS))
OS_NAME := Windows
OS_CPU  := $(call _lower,$(PROCESSOR_ARCHITECTURE))
OS_ARCH := $(if $(findstring amd64,$(OS_CPU)),x86_64,i686)
else
OS_NAME := $(shell uname -s)
OS_ARCH := $(shell uname -m)
OS_CPU  := $(if $(findstring 64,$(OS_ARCH)),amd64,x86)
endif

MAKEF_PATH = $(shell pwd)

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# This is useful if you want to put , into $(error ...) or ($info ...) messages
COMMA := ,

# This is useful if you want to put \n into $(error ...) or ($info ...) messages
define NEWLINE


endef

define logInfo
	if [ "$(CCF_LOG_LEVEL)" = 'INFO' ]; then
		echo "$1"
	fi
endef

TARGET_MAX_CHAR_NUM ?= 15
# All targets should have a ## Help text above the target and they'll be automatically collected
# Show help, using auto generator from https://gist.github.com/prwhite/8168133
help:
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${WHITE}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

