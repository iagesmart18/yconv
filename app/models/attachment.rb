class Attachment < ApplicationRecord
  has_attached_file :file
  # validates_attachment_content_type :file, content_type: [/\Avideo/, /./]
  do_not_validate_attachment_file_type :file

end
