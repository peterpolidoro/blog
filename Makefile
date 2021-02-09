# Makefile for Blogging using GNU Emacs & Org mode

# Usage:
# `make` or `make publish`: Publish files using available Emacs configuration.
# `make publish_no_init`: Publish files without using Emacs configuration.
# `make clean`: Delete existing docs/ directory and cached file under ~/.org-timestamps/

.PHONY: all publish publish_no_init

EMACS =

ifndef EMACS
EMACS = "emacs"
endif

all: publish

publish: publish.el
	@echo "Publishing... with current Emacs configurations."
	${EMACS} --batch --load publish.el --funcall org-publish-all
	mkdir -p docs/blog
	stow -v -R --ignore=blog -t docs/blog docs

publish_no_init: publish.el
	@echo "Publishing... with --no-init."
	${EMACS} --batch --no-init --load publish.el --funcall org-publish-all
	mkdir -p docs/blog
	stow -v -R --ignore=blog -t docs/blog docs

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf docs
	@rm -rvf ~/.org-timestamps/*

serve:
	python3 -m http.server --directory=docs/
