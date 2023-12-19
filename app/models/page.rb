# frozen_string_literal: true

class Page < ApplicationRecord
  enum status: { draft: 0, published: 1, archived: 2 }, _prefix: true

  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }

end
