class Content < ApplicationRecord
  include AASM
  has_many :attachments, dependent: :destroy

  after_destroy :remove_source_file

  aasm column: :state do
    state :init, initial: true
    state :downloading
    state :converting
    state :processed


    event :rollback do
      transitions from: :downloading, to: :init
    end

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

  def total_file_size
    attachments.map do |attachment|
      return attachment.file.size if attachment.file.present?
      0
    end
  end

  private

  def remove_source_file
    if source_filename && File.exist?(source_filename)
      File.delete source_filename
    end
  end

end
