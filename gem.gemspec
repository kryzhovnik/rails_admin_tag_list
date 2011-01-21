# coding: UTF-8

Gem::Specification.new do |s|
  s.add_development_dependency('devise', '~> 1.1')
  s.add_development_dependency('acts-as-taggable-on', '~> 2.0')
  s.add_development_dependency('rspec-rails', '~> 2.4')
  s.add_development_dependency('webrat', '~> 0.7')
  s.add_development_dependency('yard', '~> 0.6')

  # If you add a runtime dependency, please maintain alphabetical order
  s.add_runtime_dependency('builder', '~> 2.1.0')
  s.add_runtime_dependency('rails', '~> 3.0.3')
  
  s.name              = "rails_admin_tag_list_field"
  s.version           = "0.0.1"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Andrey Samsonov"]
  s.email             = ["andrey.samsonov@gmail.com"]
  s.homepage          = "http://github.com/kryzhovnik/rails_admin_tag_list_field"
  s.summary           = "Support acts_as_taggable_on gem for rails_admin"
  s.description       = "That gem implements field type and partial for \"tag_list\"(*_list) virtual attribute."
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.6"

  s.files             = `git ls-files`.split("\n")
  s.require_path      = 'lib'
end
