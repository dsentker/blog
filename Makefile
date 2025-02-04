#!/usr/bin/make

help:
	@grep -B1 -E "^[a-zA-Z0-9_-]+\:([^\=]|$$)" Makefile \
         | grep -v -- -- \
         | sed 'N;s/\n/###/' \
         | sed -n 's/^#: \(.*\)###\(.*\):.*/ > \2###\1/p' \
         | column -t -s '###'
	 @echo

#: Serve locally (with drafts too)
serve:
	hugo server --buildDrafts --cleanDestinationDir

#: Serve locally with prod environment settings
serve-prod:
	HUGO_ENVIRONMENT=production HUGO_ENV=production hugo server --gc --minify --cleanDestinationDir --noHTTPCache

#: Create a new post
post:
	./create_post.sh

#: Update themes
theme-update:
	git submodule update --remote --merge

#: Install Hugo
install:
	sudo snap install hugo --channel=extended
	@echo "Proceed with hugo new site <yourName>"