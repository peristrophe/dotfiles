### ref: https://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
### POWERED BY: https://github.com/b4b4r07/dotfiles

DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
BREWFILES  := $(wildcard Brewfile*)

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

##init: ## Setup environment settings
##	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh
##
##test: ## Test dotfiles and init scripts
##	@#DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/test/test.sh
##	@echo "test is inactive temporarily"
##
##update: ## Fetch changes for this repo
##	git pull origin master
##	git submodule init
##	git submodule update
##	git submodule foreach git pull origin master

install: ## Run brew bundle
	@$(foreach val, $(BREWFILES), brew bundle --file=$(val);)

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
