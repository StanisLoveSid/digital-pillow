class AddFieldsToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :type, :string
    add_column :addresses, :country, :string
    add_column :addresses, :addressing, :string
  end
end
