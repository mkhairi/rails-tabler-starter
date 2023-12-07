# frozen_string_literal: true

class PlainTextInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    value = options[:value] || @builder.object.send(attribute_name)
    input_html_classes.unshift("form-control-plaintext")
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    template.text_field_tag(attribute_name, value, merged_input_options)
  end
end
