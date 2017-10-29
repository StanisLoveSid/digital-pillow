class AddDimensionIdToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :dimension_id, :integer
  end
end
