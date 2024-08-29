.PHONY: test prepare clean

test: prepare
	(cd app && ./reproduce.rb)

prepare: clean
	# Create .git repositories
	(cd app            && git init && git add . --all && git commit -m 'init') > /dev/null
	(cd bar-git        && git init && git add . --all && git commit -m 'init') > /dev/null
	(cd bar-git-fixed  && git init && git add . --all && git commit -m 'init') > /dev/null
	(cd bar-path       && git init && git add . --all && git commit -m 'init') > /dev/null
	# Configure local overrides
	(cd app && bundle config --local local.bar-git        `readlink -f ../bar-git`)
	(cd app && bundle config --local local.bar-git-fixed  `readlink -f ../bar-git-fixed`)
	(cd app && bundle config --local local.bar-path       `readlink -f ../bar-path`)
	(cd app && bundle install) > /dev/null
	# Versions
	(cd app && ruby --version)
	(cd app && bundler --version)

clean:
	rm -f app/Gemfile.lock
	rm -rf */.git
