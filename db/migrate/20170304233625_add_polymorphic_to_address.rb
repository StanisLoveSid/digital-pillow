class AddPolymorphicToAddress < ActiveRecord::Migration[5.0]
  def up
    change_table :addresses do |t|
      t.references :addressable, :polymorphic => true
    end
  end

  def down
    change_table :addresses do |t|
      t.remove_references :addressable, :polymorphic => true
    end
  end
end
