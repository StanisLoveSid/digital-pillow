class AddAllowToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :allow, :string
  end
end
