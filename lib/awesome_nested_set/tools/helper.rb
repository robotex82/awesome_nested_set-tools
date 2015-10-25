module AwesomeNestedSet
  module Tools
    module Helper
      def nested_li(objects, options = {}, &block)
        options.reverse_merge!({
          tree_css_classes: 'list-group',
          item_css_classes: 'list-group-item'
        })

        objects = objects.order(:lft) if objects.is_a? Class

        return '' if objects.size == 0

        if objects.first.root?
          output = "<ul class=\"#{options[:tree_css_classes]}\"><li class=\"#{options[:item_css_classes]}\">"
        else
          output = ''
        end
        path = [nil]

        objects.each_with_index do |o, i|
          if o.parent_id != path.last
            # We are on a new level, did we decend or ascend?
            if path.include?(o.parent_id)
              # Remove wrong wrong tailing paths elements
              while path.last != o.parent_id
                path.pop
                output << '</li></ul>'
              end
              output << "</li><li class=\"#{options[:item_css_classes]}\">"
            else
              path << o.parent_id
              if i == 0 && !objects.first.root?
                output << "<ul class=\"#{options[:tree_css_classes]}\"><li class=\"#{options[:item_css_classes]}\">"
              else
                output << "<ul><li class=\"#{options[:item_css_classes]}\">"
              end
            end
          elsif i != 0
            output << "</li><li class=\"#{options[:item_css_classes]}\">"
          end
          o = o.first if o.is_a? Array
          output << capture(o, path.size - 1, &block)
        end

        if objects.first.root?
          output << '</li></ul>' * path.length
        else
          output << '</li></ul>' * (path.length - 1)
        end
        output.html_safe
      end

      def sorted_nested_li(objects, order, &block)
        nested_li sort_list(objects, order), &block
      end

      private

      def sort_list(objects, order)
        objects = objects.order(:lft) if objects.is_a? Class

       # Partition the results
        children_of = {}
        objects.each do |o|
          children_of[ o.parent_id ] ||= []
          children_of[ o.parent_id ] << o
        end

        # Sort each sub-list individually
        children_of.each_value do |children|
          children.sort_by! &order
        end

        # Re-join them into a single list
        results = []
        recombine_lists(results, children_of, nil)

        results
      end

      def recombine_lists(results, children_of, parent_id)
        if children_of[parent_id]
          children_of[parent_id].each do |o|
            results << o
            recombine_lists(results, children_of, o.id)
          end
        end
      end
    end
  end
end
