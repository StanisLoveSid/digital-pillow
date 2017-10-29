class AddSizeToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :size, :string
  end
end
