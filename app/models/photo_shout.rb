# frozen_string_literal: true

class PhotoShout < ApplicationRecord
  has_attached_file :image, styles: { thumb: '200x200' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}
end
