
.PHONY: install
install: install_dotfiles setup_vim

.PHONY: install_dotfiles
install_dotfiles:
	for src in $(shell find "$(CURDIR)/home" -mindepth 1 -maxdepth 1); do \
		dst=$(HOME)/.$$(basename "$$src"); \
		ln -snf "$$src" "$$dst"; \
	done;
	
	ln -snf "$(CURDIR)/home/Xresources" "$(HOME)/.Xdefaults"
	xrdb -merge $(HOME)/.Xdefaults || true
	xrdb -merge $(HOME)/.Xresources || true
	fc-cache -f -v || true

.PHONY: setup_vim
setup_vim:
	vim -u "$(HOME)/.vimrc" +PlugInstall +qall

.PHONY: update
update:
	curl -L https://github.com/sindresorhus/pure/archive/master.tar.gz | tar xz --strip-components=1 -C $(CURDIR)/home/zsh/pure
	curl -L https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz | tar xz --strip-components=1 -C $(CURDIR)/home/zsh/zsh-syntax-highlighting

