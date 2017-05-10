class AddAttachmentToContent < ActiveRecord::Migration[5.0]
  def change
    add_attachment :contents, :attachment
  end
end
