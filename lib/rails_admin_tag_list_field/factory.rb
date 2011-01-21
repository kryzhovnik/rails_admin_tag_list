require 'rails_admin_tag_list_field/rails_admin/config/fields/types/tag_list'

module RailsAdminTagListField
  def self.factory
    lambda do |parent, properties, fields|
      model = parent.abstract_model.model
      if defined?(::ActsAsTaggableOn) && model.taggable?
        # acts_as_taggable_on
        tag_types = model.tag_types
        singularized_tag_types = tag_types.map{|t| t.to_s.singularize}
        aato_associations = [:taggings, :base_tags] + tag_types \
          + singularized_tag_types.map{|tag| "#{tag}_taggings"}.map(&:to_sym)
        if aato_associations.include?(properties[:name])
          fields_names = singularized_tag_types.map{|tag| "#{tag}_list"}
          aato_associations.each do |association_name|
            if props = parent.abstract_model.associations.find {|a| association_name == a[:name] }
              if RailsAdmin::Config::Fields.default_factory.call(parent, props, fields)
                fields.last.hide
              end
            end
          end
          fields_names.each do |field_name|
            properties = {
              :name => field_name,
              :pretty_name => model.human_attribute_name(field_name),
              :type => :tag_list,
              :length => 255,
              :nullable? => true,
              :serial? => false
            }
            fields << RailsAdmin::Config::Fields::Types::TagList.new(parent, field_name.to_sym,   properties)
          end
          true
        else
          false
        end
      else
        false
      end
    end
  end
end
