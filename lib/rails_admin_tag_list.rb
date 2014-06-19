require "rails_admin_tag_list/engine"

module RailsAdminTagList
end

require 'rails_admin/config/fields'
require 'rails_admin/config/fields/base'

module RailsAdmin
  module Config
    module Fields
      module Types
        class TagList < RailsAdmin::Config::Fields::Base
          RailsAdmin::Config::Fields::Types::register(self)
          register_instance_option(:formatted_value) do
            value.join(', ')
          end

          register_instance_option(:pretty_value) do
            value.join(', ')
          end
          # Accessor for field's label.
          #
          # @see RailsAdmin::AbstractModel.properties
          register_instance_option(:help) do
            I18n.t(:tag_list_help, :scope => [:admin, :new], :default => 'Use commas to separate tags')
          end
          register_instance_option(:partial) do
            :form_tag_list
          end
        end
      end
    end
  end
end

RailsAdmin::Config::Fields.register_factory do |parent, properties, fields|
  model = parent.abstract_model.model

  if defined?(::ActsAsTaggableOn) && model.taggable?
    tag_types = model.tag_types
    if tag_types.include?(properties.name)
      name = "#{properties.name.to_s.singularize}_list".to_sym

      fields << RailsAdmin::Config::Fields::Types::TagList.new(parent, name, properties)
    end
  end
  false
end
