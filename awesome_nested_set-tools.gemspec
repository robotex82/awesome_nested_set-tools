$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "awesome_nested_set/tools/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "awesome_nested_set-tools"
  s.version     = AwesomeNestedSet::Tools::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/awesome_nested_set-tools"
  s.summary     = "Provides helpers and tools for awesome nested set."
  s.description = "Provides helpers and tools for awesome nested set."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"

  s.add_development_dependency "sqlite3"

  # Documentation
  s.add_development_dependency "yard"
  s.add_development_dependency "thin"
end
