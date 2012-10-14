$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "citizen/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "citizen"
  s.version     = Citizen::VERSION
  s.authors     = ["James Kassemi"]
  s.email       = ["james@atpay.com"]
  s.homepage    = "https://github.com/EasyGive/citizen"
  s.summary     = "Reusable first class citizen AM extension for basic models"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"

  s.add_development_dependency "sqlite3"
end
