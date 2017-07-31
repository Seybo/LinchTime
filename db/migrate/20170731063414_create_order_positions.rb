class CreateOrderPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :order_positions do |t|
      t.references :person, foreign_key: true, null: false
      t.references :meal, foreign_key: true, null: false

      t.timestamps
    end
  end
end
