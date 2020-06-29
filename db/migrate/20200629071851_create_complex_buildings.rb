class CreateComplexBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :complex_buildings do |t|
      t.string :owner
      t.string :address
      t.integer :units
      t.integer :sqmt
      t.decimal :price

      t.timestamps
    end
  end
end
