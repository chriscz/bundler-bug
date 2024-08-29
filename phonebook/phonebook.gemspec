require_relative "lib/phonebook/version"

Gem::Specification.new do |spec|
  spec.name        = "phonebook"
  spec.version     = Phonebook::VERSION
  spec.authors     = ["Chris Coetzee"]
  spec.email       = ["chris@example.com"]
  spec.summary     = ""
  spec.license     = "MIT"
  spec.files = Dir["{app,config,db,lib,exe}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
end
