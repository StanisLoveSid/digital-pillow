class AddNovaPoshtaPriceToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :nova_poshta_delivery, :float
  end
end
