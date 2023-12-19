# frozen_string_literal: true

module IconsHelper
  def icon(filename, options = {})
    icon_name = filename.to_s.dasherize
    InlineSvg::TransformPipeline.generate_html_from(read_tabler_svg(icon_name), options).html_safe
  rescue StandardError
    tag.span(icon_name) + content_tag(:span, icon_name, class: 'ml-1')
  end

  def icons_path
    Rails.public_path.join("assets/icons")
  end

  def read_tabler_svg(filename)
    File.read("#{icons_path}/#{filename}.svg")
  end
end
