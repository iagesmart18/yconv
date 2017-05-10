class Content < ApplicationRecord
  include AASM
  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: [/\Avideo/]


end
