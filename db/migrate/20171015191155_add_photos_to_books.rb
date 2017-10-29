class AddPhotosToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :photos, :json
  end
end
