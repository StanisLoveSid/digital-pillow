class AddWeightToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :weight, :float, default: 0
  end
end
