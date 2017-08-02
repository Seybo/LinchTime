class AddIndexToMeal < ActiveRecord::Migration[5.1]
  def change
    add_index :meals, :name
  end
end
