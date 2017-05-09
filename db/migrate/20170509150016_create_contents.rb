class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :name, index: true
      t.text :human_name
      t.string :format
      t.integer :parent_id
      t.timestamps
    end
  end
end
