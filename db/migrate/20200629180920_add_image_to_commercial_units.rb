class AddImageToCommercialUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_units, :image, :string
  end
end
