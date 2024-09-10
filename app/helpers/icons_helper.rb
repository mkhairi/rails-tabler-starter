# frozen_string_literal: true

module IconsHelper
  def icon(name, text = nil, options = {})
    if text.is_a?(Hash)
      options = text
      text = nil
    end
    options.reverse_merge!({ class: "" })
    options["id"] = nil
    options["class"] = options[:class]
    options["width"] = "24px"
    options["height"] = "24px"

    if options.key?(:tooltip)
      options["data-bs-toggle"] = "tooltip"
      options["data-bs-placement"] = "top"
      options["data-bs-title"] = options.delete(:tooltip)
    end

    style = options.delete(:filled) ? "filled" : "outline"

    icon = InlineSvg::TransformPipeline.generate_html_from(read_tabler_svg(name.to_s, style), options)
    return icon.html_safe if text.blank?

    icon.html_safe + content_tag(:span, text, class: "ms-1")
  rescue StandardError
    tag.span(name.to_s) + content_tag(:span, text, class: "ms-1 icon-not-found")
  end

  def icons_path(style)
    Rails.public_path.join("assets/icons/#{style}")
  end

  def read_tabler_svg(filename, style = "outline")
    File.read("#{icons_path(style)}/#{filename.to_s.dasherize}.svg")
  end
end
