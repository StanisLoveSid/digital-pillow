class ChangePickTimesToDefault < ActiveRecord::Migration[5.0]
  def change
  	change_column(:books, :pick_times, :integer, default: 0)
  end
end
