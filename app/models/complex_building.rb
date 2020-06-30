class ComplexBuilding < ApplicationRecord
    validates :owner, :address, :image, :price, presence: true
end
