TARGET_MAX_CHAR_NUM=15
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

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

comma := ,
define logInfo
	if [ "$(CCF_LOG_LEVEL)" = 'INFO' ]; then
		echo "$1"
	fi
endef

define NEWLINE


endef

define logInfo
	if [ "$(CCF_LOG_LEVEL)" = 'INFO' ]; then
		echo "$1"
	fi
endef
