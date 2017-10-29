class AddPriceIdToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :price_id, :integer
  end
end
