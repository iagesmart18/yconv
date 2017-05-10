class AddUrlToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :url, :string
  end
end
