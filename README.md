## The Problem
Bundler is not evaluating a gem's `gemspec` file within the directory where the gem is located when you have a local
override in place for a `gem "bar-git", git: XXX` installed dependency, consequently `spec.files` is not being calculated correctly.

The key difference between `bar-git` and `bar-git-fixed` is that the latter does a `Dir.chdir`, ensuring it evaluates correctly.

```
# bar-git.gemspec
spec.files = Dir["{app,config,db,lib,exe}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
```

```
# bar-git-fixed
Dir.chdir(File.expand_path(__dir__)) do
  spec.files = Dir["{app,config,db,lib,exe}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
end
```

One cannot guarantee that all gems will do this, hence this bug ticket.

## Overview
This repo explores bundler install scenarios for three gems installed and used by `app`:

1. `bar-path` is included by Path in `app/Gemfile`
2. `bar-git` is included by git + local override in `app/Gemfile`
3. `bar-git-fixed` uses a chdir within the gemspec to ensure that `spec.files` is evaluated correctly. 
    This has become the default when generating a new gem using `bundle gem <gem_name>`, 
    but it is unlikely to be the case across the board.

The test shows that gems overriden using git + local override (`bundle config local.GEM_NAME`) have their
gemfiles evaluated in the current directory instead of the root directory of the gemspec.

## Steps to reproduce
```
git clone git@github.com:chriscz/bundler-bug
make
```

After testing you should see the following:

```
=== PATH-based include [local override applied]
✅ PASS: assert Gem::Specification(name="bar-path").executables.include?("bar-path-1")
✅ PASS: assert Gem::Specification(name="bar-path").executables.include?("bar-path-2")

=== GIT-based include [local override applied]
❌ FAIL: assert Bundler::StubSpecification(name="bar-git").executables.include?("bar-git-1")
         got executables: []
❌ FAIL: assert Bundler::StubSpecification(name="bar-git").executables.include?("bar-git-2")
         got executables: []

=== GIT-based include (with fix) [local override applied]
✅ PASS: assert Bundler::StubSpecification(name="bar-git-fixed").executables.include?("bar-git-fixed-1")
✅ PASS: assert Bundler::StubSpecification(name="bar-git-fixed").executables.include?("bar-git-fixed-2")
```

This shows that the working directory when evaluating the gemspec for the second gem `bar-git` is incorrect since its executables could not be found.

Please see the `app/reproduce.rb` script for how this is done

## Steps to prepare for ocmmit
```
make clean
git add .
git commit -m "Your message here"
```
