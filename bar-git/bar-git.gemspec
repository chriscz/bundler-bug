require_relative "lib/bar/git/version"

Gem::Specification.new do |spec|
  spec.name        = "bar-git"
  spec.version     = Bar::Git::VERSION
  spec.authors     = ["Chris Coetzee"]
  spec.email       = ["chriscz93@gmail.com"]
  spec.summary     = ""

  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib,exe}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.bindir = "exe"

  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
end
