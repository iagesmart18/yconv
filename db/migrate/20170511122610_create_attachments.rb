class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :content
      t.attachment :file
      t.string :format
      t.timestamps
    end
  end
end
