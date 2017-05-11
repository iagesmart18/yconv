class RemoveAttachmentFromContent < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :contents, :attachment
    remove_column :contents, :format
    remove_column :contents, :parent_id
  end
end
