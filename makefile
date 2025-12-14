.PHONY: install uninstall bash source install-bash uninstall-bash

PROJECT_NAME := mountssh
PREFIX := /usr/local
BIN_DIR := $(PREFIX)/bin

# Argument parsing logic
ACTION := $(word 1, $(MAKECMDGOALS))
METHOD := $(word 2, $(MAKECMDGOALS))
VALID_ACTIONS := install uninstall
VALID_METHODS := source bash

# Header guard
ifeq ($(MAKELEVEL),0)

# if we are not root: exit
ifneq ($(shell id -u),0)
$(error run make as root)
endif

## disallow `make [target]`
ifneq ($(filter $(ACTION),$(VALID_METHODS)),)
$(error use `make [action] [target]` not `make [target]`)
endif

## require [action]
ifeq ($(filter $(ACTION),$(VALID_ACTIONS)),)
$(error missing action use `$(VALID_ACTIONS)`, syntax: make [action] [target] )
endif

## require [method]
ifeq ($(METHOD),)
$(error missing method, valid methods: `$(VALID_METHODS)`)
endif

## validate method name
ifeq ($(filter $(METHOD),$(VALID_METHODS)),)
$(error $(METHOD) did not match any valid methods name `$(VALID_METHODS)`)
endif

endif # end of CHECK guard

$(VALID_METHODS):
	@:

# Action install
install:
	@echo "==> installing via method=$(METHOD)"
	@$(MAKE) --no-print-directory install-$(METHOD)

# Action uninstall
uninstall:
	@echo "==> un-installing via method=$(METHOD)"
	@$(MAKE) --no-print-directory uninstall-$(METHOD)

### Build recipies ###
install-bash:
	@echo install -m0755 -oroot -groot ./bash/$(PROJECT_NAME) $(BIN_DIR)/mountssh
	@{ install -m0755 -oroot -groot ./bash/$(PROJECT_NAME) $(BIN_DIR)/mountssh && \
		printf '[%s]: %s\n' info "successful install complete"; } || \
		printf '[%s]: %s\n' info "installation failed"

uninstall-bash:
	@echo sudo rm $(BIN_DIR)/$(PROJECT_NAME)
	@cd $(BIN_DIR) && { { rm ./$(PROJECT_NAME) && \
		printf '[%s]: %s\n' info "successful uninstall"; } || \
		printf '[%s]: %s\n' error "failed to uninstall"; }

