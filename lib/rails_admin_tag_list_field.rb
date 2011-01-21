require 'rails_admin'
load 'rails_admin_tag_list_field/engine.rb'
load 'rails_admin_tag_list_field/factory.rb'

# Register acts_as_taggable_on field factory
tag_list_factory = RailsAdminTagListField.factory
RailsAdmin::Config::Fields.register_factory(&tag_list_factory)
