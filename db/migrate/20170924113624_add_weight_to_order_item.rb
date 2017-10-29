class AddWeightToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :unit_weight, :float, default: 0
    add_column :order_items, :total_weight, :float, default: 0
  end
end
