.PHONY: install uninstall purge remove bash symlink source install-bash uninstall-project

PROJECT_NAME := mountssh
PROJECT_PATH := ./bin
PREFIX := /usr/local
BIN_DIR := $(PREFIX)/bin
MAN_SECTION := 1
MAN_DIR := /usr/local/share/man/man$(MAN_SECTION)
MAN_NAME := $(PROJECT_NAME).$(MAN_SECTION)

# argument parsing logic
ACTION := $(word 1, $(MAKECMDGOALS))
METHOD := $(word 2, $(MAKECMDGOALS))
VALID_ACTIONS := install uninstall build purge remove
VALID_METHODS := source bash symlink

# safety guard
ifeq ($(MAKELEVEL),0)

## action must not be method
ifneq ($(filter $(ACTION),$(VALID_METHODS)),)
$(error use `make [action] [target]` not `make [target]`)
endif

## action must be valid
ifeq ($(filter $(ACTION),$(VALID_ACTIONS)),)
$(error invalid action `$(ACTION)`, valid actions `$(VALID_ACTIONS)`)
endif

## skip method check on build and uninstall
ifeq ($(filter $(ACTION),build uninstall),)

## root only operations ##
ifneq ($(shell id -u),0)
$(error run make as root)
endif

## default method if not given
ifeq ($(METHOD),)
METHOD := bash
endif

## validate method name
ifeq ($(filter $(METHOD),$(VALID_METHODS)),)
$(error $(METHOD) did not match any valid methods name `$(VALID_METHODS)`)
endif

endif # end of SKIP check

endif # end of CHECK guard

$(VALID_METHODS):
	@:

install:
	@printf '%s\n' "==> installing [method: $(METHOD)]"
	@$(MAKE) --no-print-directory install-$(METHOD)

uninstall:
	@printf '%s\n' "==> un-installing"
	@$(MAKE) --no-print-directory uninstall-project

build:
	@printf '%s\n' "help2man -N --locale=en_US.UTF-8 $(PROJECT_PATH)/$(PROJECT_NAME) -o ./man/$(MAN_NAME)"
	@mkdir -p ./man/
	@env FULL_USAGE=yes help2man -N --locale="en_US.UTF-8" "$(PROJECT_PATH)/$(PROJECT_NAME)" -o ./"man/$(MAN_NAME)"

install-bash:
	@printf '%s\n' "install -m0755 -oroot -groot $(PROJECT_PATH)/$(PROJECT_NAME) $(BIN_DIR)/$(PROJECT_NAME)"
	@mkdir -p "$(BIN_DIR)" "$(MAN_DIR)"
	@{ install -m0755 -oroot -groot "$(PROJECT_PATH)/$(PROJECT_NAME)" "$(BIN_DIR)/$(PROJECT_NAME)" && \
		printf '[info]: %s\n' "successful install \`$(BIN_DIR)/$(PROJECT_NAME)\`"; } || \
		printf '[error]: %s\n' "installation failed \`$(BIN_DIR)/$(PROJECT_NAME)\`"
	@$(MAKE) --no-print-directory install-man

install-symlink:
	@printf '%s\n' "ln -sf $(shell readlink -f "$(PROJECT_PATH)/$(PROJECT_NAME)") $(BIN_DIR)/$(PROJECT_NAME)"
	@mkdir -p "$(BIN_DIR)" "$(MAN_DIR)"
	@{ ln -sf "$(shell readlink -f "$(PROJECT_PATH)/$(PROJECT_NAME)")" "$(BIN_DIR)/$(PROJECT_NAME)" && \
		printf '[info]: %s\n' "successful created symlink \`$(BIN_DIR)/$(PROJECT_NAME)\`"; } || \
		printf '[error]: %s\n' "failed to create symlink \`$(BIN_DIR)/$(PROJECT_NAME)\`"
	@$(MAKE) --no-print-directory install-man

install-man:
	@printf '%s\n' "install -m0755 -oroot -groot ./man/$(MAN_NAME) $(MAN_DIR)/$(MAN_NAME)"
	@{ install -m0755 -oroot -groot ./"man/$(MAN_NAME)" "$(MAN_DIR)/$(MAN_NAME)" && \
		printf '[info]: %s\n' "successful install \`$(MAN_DIR)/$(MAN_NAME)\`"; } || \
		printf '[error]: %s\n' "installation failed \`$(MAN_DIR)/$(MAN_NAME)\`"

uninstall-project:
	@printf '%s\n' "rm $(BIN_DIR)/$(PROJECT_NAME)"
	@cd $(BIN_DIR) || { printf '[error]: %s\n' "failed to chdir \`$(BIN_DIR)\`"; exit 1; }
	@{ rm ./"$(PROJECT_NAME)" && printf '[info]: %s\n' "successful uninstall \`$(BIN_DIR)/$(PROJECT_NAME)\`"; } || \
		printf '[error]: %s\n' "failed to uninstall \`$(BIN_DIR)/$(PROJECT_NAME)\`"
	@printf '%s\n' "rm $(MAN_DIR)/$(MAN_NAME)"
	@cd $(MAN_DIR) || { printf '[error]: %s\n' "failed to chdir \`$(MAN_DIR)\`"; exit 1; }
	@{ rm ./"$(MAN_NAME)" && printf '[info]: %s\n' "successful uninstall \`$(MAN_DIR)/$(MAN_NAME)\`"; } || \
			printf '[error]: %s\n' "failed to uninstall \`$(MAN_DIR)/$(MAN_NAME)\`"
