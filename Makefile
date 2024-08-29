.PHONY: test prepare clean

test: prepare
	(cd app-gem && ./bundle-add-local-bar)
	(cd app-gem && bundle config --local local.bar-git `readlink -f ../bar-git`)
	(cd app-gem && bundle config --local local.bar-git-fixed `readlink -f ../bar-git-fixed`)
	(cd app-gem && bundle config --local local.engine_git `readlink -f ../engine_git`)
	(cd app-gem && rm -f Gemfile.lock)
	(cd app-gem && bundle install)
	(cd app-gem && ./reproduce.rb)

prepare:
	./prepare

clean:
	rm -rf */.git
