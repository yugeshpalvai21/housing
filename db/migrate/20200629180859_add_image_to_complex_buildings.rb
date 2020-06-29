class AddImageToComplexBuildings < ActiveRecord::Migration[5.2]
  def change
    add_column :complex_buildings, :image, :string
  end
end
