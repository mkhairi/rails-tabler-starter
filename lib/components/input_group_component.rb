# frozen_string_literal: true

# custom component requires input group wrapper
module InputGroupComponent
  def prepend(args = nil)
    if args[:icon_addon]
      template.content_tag(:span, options[:prepend], class: "input-icon-addon")
    else
      template.content_tag(:span, options[:prepend], class: "input-group-text")
    end
  end

  def append(args = nil)
    if args[:icon_addon]
      template.content_tag(:span, options[:append], class: "input-icon-addon")
    else
      template.content_tag(:span, options[:append], class: "input-group-text")
    end
  end

  def text(args = nil)
    template.content_tag(:span, args[:text], class: args[:class])
  end
end

# Register the component in Simple Form.
SimpleForm.include_component(InputGroupComponent)
