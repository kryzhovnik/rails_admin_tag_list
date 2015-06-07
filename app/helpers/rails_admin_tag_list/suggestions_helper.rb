module RailsAdminTagList
  module SuggestionsHelper

    def ratl_suggestions(field, options={})
      options = options.merge(max_count: field.ratl_max_suggestions)

      tags = ratl_tags(field)
      sorted_tags = ratl_sort_tags(tags, options[:order])
      sorted_tags[0..options[:max_count]].map(&:name)
    end

    private

      def ratl_tags(field)
        model = field.abstract_model.model_name.constantize
        tags_name = field.name.to_s.gsub(/_list/, '').pluralize.to_sym
        
        model.tag_counts_on(tags_name)
      end

      def ratl_sort_tags(tags, order)
        case order.to_sym
        when :count
          tags.sort_by { |tag| -tag.count }
        when :name
          tags.sort_by { |tag| tag.name }
        when :rand, :random, :shuffle
          tags.shuffle
        else
          raise ArgumentError.new("RailsAdminTagList field unrecognized sorting order")
        end
      end
  end
end
