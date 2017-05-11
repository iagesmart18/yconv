class Content < ApplicationRecord
  include AASM
  has_many :attachments, dependent: :destroy

  aasm column: :state do
    state :init, initial: true
    state :downloading
    state :converting
    state :processed

    event :download do
      transitions from: :init, to: :downloading
      transitions from: :downloading, to: :downloading
    end

    event :convert do
      transitions from: :downloading, to: :converting
      transitions from: :converting, to: :converting
    end

    event :finish  do
      transitions from: :converting, to: :processed
      transitions from: :downloading, to: :processed
    end
  end

end
