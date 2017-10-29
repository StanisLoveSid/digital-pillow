class CreateDimensions < ActiveRecord::Migration[5.0]
  def change
    create_table :dimensions do |t|
      t.string :size

      t.timestamps
    end
  end
end
