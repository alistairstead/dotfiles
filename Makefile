EMACS ?= emacs
CASK ?= cask
BASH ?= bash
GIT ?= git

test:
	${EMACS} --version

submodules:
	${GIT} submodule update --init --force --remote

install: clean
	${MAKE} install-homebrew
	${MAKE} install-node
	${MAKE} init.el
	${CASK} install

install-homebrew:
	${BASH} ./scripts/homebrew-install.sh
	${BASH} ./scripts/homebrew-install-recipes.sh
	${BASH} ./scripts/homebrew-install-casks.sh
	${BASH} ./scripts/homebrew-install-fonts.sh

install-node:
	${BASH} ./scripts/node-install.sh

Cask:
	${RM} Cask
	${MAKE} init.el

clean:
	$(RM) init.el Cask
	$(RM) *.elc
	$(RM) */*.elc

# Use emacs to generate init.el from init.org
# we first tangle the org-mode file to init.el~ the rename it.
# this can make use use async task to create another init.el after save.
init.el:
	${EMACS} -Q -batch \
		--eval "(require 'org)" \
		--eval '(setq org-confirm-babel-evaluate nil)' \
		--eval '(setq org-confirm-execute-src-block nil)' \
		--eval '(if (file-exists-p "init.el~") (delete-file "init.el~" nil))' \
		--eval '(org-babel-tangle-file "init.org" "init.el~")' \
		--eval '(rename-file "init.el~" "init.el" t)'

.PHONY: install install-homebrew install-node init.el test
