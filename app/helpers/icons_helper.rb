# frozen_string_literal: true

module IconsHelper
  def icon(filename, options = {})
    InlineSvg::TransformPipeline.generate_html_from(read_tabler_svg(filename), options).html_safe
  end

  private

  def icons_path
    Rails.root.join('node_modules/@tabler/icons/icons')
  end

  def read_tabler_svg(filename)
    File.read("#{icons_path}/#{filename}.svg")
  end
end
