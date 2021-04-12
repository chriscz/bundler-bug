require_relative "lib/bar/git/fixed/version"

Gem::Specification.new do |spec|
  spec.name        = "bar-git-fixed"
  spec.version     = Bar::Git::Fixed::VERSION
  spec.authors     = ["Chris Coetzee"]
  spec.email       = ["chriscz93@gmail.com"]
  spec.summary     = ""

  spec.license     = "MIT"

  Dir.chdir(File.expand_path(__dir__)) do
    spec.files = Dir["{app,config,db,lib,exe}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.bindir = "exe"

  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
end
