fmt:
	@shfmt --version
	@find . -maxdepth 3 -name '*.sh' | while read -r src; do shfmt -w -p "$$src"; done
	@find . -maxdepth 3 -name '*.zsh' | while read -r src; do shfmt -w "$$src"; done;

check:
	@curl -sL https://git.io/shcheck | bash -f -s -- \
		--ignore 'ruby/rbenv.zsh' \
		--ignore 'zshrc.d/config.zsh' \
		--ignore 'zshrc.d/completion.zsh' \
		--ignore 'zshrc.d/prompt.zsh' \
		--ignore 'zshrc.d/window.zsh' \
		--ignore 'zshrc.d/fpath.zsh' \
		--ignore 'script/test.sh'

docker_build:
	docker build -t dotfiles .

docker_run:
	docker run -it dotfiles

test: check
	./script/test
