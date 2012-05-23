module ActiveAdmin
  module Inputs
    class FilterAutocompleteInput < ::Formtastic::Inputs::StringInput
      include FilterBase

      # TODO: try to use only input_html_options

      def to_html
        input_wrapping do
          label_html <<
            builder.text_field(input_name, input_html_options)
        end
      end

      def label_text
        I18n.t('active_admin.search_field', :field => super)
      end

      def input_name
        "#{super}_contains"
      end

      def input_html_options
        options = super
        options['id'] = "#{options[:object]}_#{method.to_s}"
        options[:class] = [options[:class], 'ui-autocomplete-input'].compact.join(' ')
        options['aria-autocomplete'] = 'list'
        options['aria-haspopup'] = 'true'
        options
      end

    end
  end
end
