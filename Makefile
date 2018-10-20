MIN_DOTFILES         := .bash_profile .bashrc .inputrc .vimrc .gitconfig
DOTFILES             := .bash_sessions_disable .gitconfig .condarc .tmux.conf .gvimrc .ideavimrc .gitignore_global .gdbinit
DOTFILES_WITH_FOLDER := .matplotlib/matplotlibrc .ipython/profile_default/startup/00first.py .jupyter/custom/custom.css .jupyter/custom/custom.js
FOLDER               := .vim/snips
OBJECTS              := $(MIN_DOTFILES) $(DOTFILES) $(DOTFILES_WITH_FOLDER) $(FOLDER)
TARGETS              := $(patsubst %,%.target,$(OBJECTS))

.PHONY: all
all: init $(TARGETS)

# 初期化関係
init:
	# バックアップフォルダを作る
	if [ ! -e backup ]; then mkdir backup; fi

define link_template
$(1).target: $(1)
	@echo
	@echo "$(1): link to $(HOME)/$(1)"
	if [ -e $(HOME)/$(1) ] && ! readlink $(HOME)/$(1); then mv $(HOME)/$(1) backup/$(1); else :; fi
	ln -sf $(abspath $(1)) $(HOME)/$(1)
endef

define folder_link_template
$(1).target: $(1)
	@echo
	@echo "$(1): link to $(HOME)/$(1)"
	mkdir -p $(dir $(HOME)/$(1))
	if [ -e $(HOME)/$(1) ] && ! readlink $(HOME)/$(1); then \
		mkdir -p backup/$(1) && mv $(HOME)/$(1) backup/$(1); \
	elif realink $(HOME)/$(1); then \
		unlink $(HOME)/$(1); \
	else :; fi
	ln -sf $(abspath $(1)) $(dir $(HOME)/$(1))
endef

define folder_template
$(1).target: $(1)
	@echo
	@echo "$(1): link to $(HOME)/$(1)"
	if [ -e $(HOME)/$(1) ] && ! readlink $(HOME)/$(1); then \
		mkdir -p backup/$(1) && mv $(HOME)/$(1) backup/$(1); \
	else mkdir -p $(dir $(HOME)/$(1)); fi
	ln -s $(abspath $(1)) $(HOME)/$(1)
endef

# テンプレート展開
$(foreach file, $(MIN_DOTFILES),         $(eval $(call link_template,$(file))))
$(foreach file, $(DOTFILES),             $(eval $(call link_template,$(file))))
$(foreach file, $(DOTFILES_WITH_FOLDER), $(eval $(call folder_link_template,$(file))))
$(foreach file, $(FOLDER),               $(eval $(call folder_template,$(file))))
