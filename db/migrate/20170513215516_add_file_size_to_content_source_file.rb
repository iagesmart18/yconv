class AddFileSizeToContentSourceFile < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :source_file_size, :integer
  end
end
