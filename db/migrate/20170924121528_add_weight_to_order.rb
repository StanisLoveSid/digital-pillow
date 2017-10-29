class AddWeightToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total_weight, :float, default: 0
  end
end
