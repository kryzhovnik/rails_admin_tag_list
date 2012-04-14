$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_tag_list/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_tag_list"
  s.version     = RailsAdminTagList::VERSION
  s.authors     = ["Andrey Samsonov"]
  s.email       = ["andrey.samsonov@gmail.com"]
  s.homepage    = "https://github.com/kryzhovnik"
  s.summary     = "Support acts_as_taggable_on gem for rails_admin"
  s.description = %(That gem implements field type and partial for "tag_list"(*_list) virtual attribute.)

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2"

  s.add_development_dependency "sqlite3"
end
