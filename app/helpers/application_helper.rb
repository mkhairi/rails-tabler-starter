# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    color =
      case type
      when "notice"
      "success"
      when "alert", "error"
      "danger"
      else
      "info"
      end
    klass = "text-bg-#{color} bg-#{color}"
  end
end
