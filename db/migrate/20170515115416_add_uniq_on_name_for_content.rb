class AddUniqOnNameForContent < ActiveRecord::Migration[5.0]
  def change
    remove_index :contents, :name
    add_index :contents, :name, unique: true
  end
end
