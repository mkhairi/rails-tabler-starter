# frozen_string_literal: true

module IconsHelper
  def icon(filename, options = {})
    InlineSvg::TransformPipeline.generate_html_from(read_tabler_svg(filename), options).html_safe
  end

  def icons_path
    Rails.public_path.join("assets/icons")
  end

  def read_tabler_svg(filename)
    File.read("#{icons_path}/#{filename}.svg")
  end
end
