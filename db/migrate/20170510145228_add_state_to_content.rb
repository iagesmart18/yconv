class AddStateToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :state, :string
  end
end
