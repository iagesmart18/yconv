class AddSourceFileToContentAndErrorMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :source_filename, :string
    add_column :contents, :error_msg, :text
  end
end
