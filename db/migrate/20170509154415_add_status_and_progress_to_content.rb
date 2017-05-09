class AddStatusAndProgressToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :status, :string
    add_column :contents, :progress, :decimal, scale: 2, precision: 4
  end
end
