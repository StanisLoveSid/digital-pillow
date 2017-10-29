class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.float :price
      t.string :size
      t.integer :book_id

      t.timestamps
    end
  end
end
