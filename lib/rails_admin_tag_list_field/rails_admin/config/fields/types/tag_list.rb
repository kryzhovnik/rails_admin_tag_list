module RailsAdmin::Config::Fields::Types
  class TagList < RailsAdmin::Config::Fields::Base
    RailsAdmin::Config::Fields::Types::register(:tag_list, self)
    @column_width = 200
    @type = :tag_list

    register_instance_option(:formatted_value) do
      value.join(', ')
    end

    register_instance_option(:partial) do
      'tag_list'
    end

    register_instance_option(:css_class) do
      'string'
    end

    register_instance_option(:help) do
      I18n.t(:tag_list_help, :scope => [:admin, :new], :default => 'Use commas to separate tags') 
    end
  end
end

