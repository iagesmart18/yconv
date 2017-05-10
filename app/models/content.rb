class Content < ApplicationRecord
  include AASM
  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: [/\Avideo/]

  aasm column: :state do
    state :init, initial: true
    state :downloading
    state :converting
    state :processed
  end

end
