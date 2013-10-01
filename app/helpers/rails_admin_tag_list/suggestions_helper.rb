module RailsAdminTagList
  module SuggestionsHelper
    def tag_suggestions(field, options = {})
      defaults = {
        :order => { :count => :desc },
        :length => 5
      }
      options = defaults.deep_merge(options)

      model = field.abstract_model.model_name.constantize
      tags_name = field.name.to_s.gsub(/_list/, '').pluralize.to_sym
      tags = model.tag_counts_on(tags_name)
      tags = sort_tags(tags, options[:order])
      tags[0..options[:length]].map(&:name)
    end
    
    def ratl_all_tags(field, options={})
      defaults = {
        :order => { :name => :asc }
      }
      options = defaults.deep_merge(options)
      model = field.abstract_model.model_name.constantize
      tags_name = field.name.to_s.gsub(/_list/, '').to_sym
      tags = model.tags_on(tags_name)
      tags = sort_tags(tags, options[:order])
      tags.map(&:name)
    end

    private
      def sort_tags(tags, options)
        if options.is_a?(Hash)
          if options[:count]
            tags = tags.sort_by(&:count)
            tags = tags.reverse if options[:count] == :desc
          end
        elsif [:rand, :random, :shuffle].include?(options)
          tags = tags.shuffle
        end
        tags
      end
  end
end
