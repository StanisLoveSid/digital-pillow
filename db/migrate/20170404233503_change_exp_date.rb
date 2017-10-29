class ChangeExpDate < ActiveRecord::Migration[5.0]
  def up
    change_column :credit_cards, :expiration_date, :string
  end

  def down
    change_column :credit_cards, :expiration_date, :integer
  end
end
