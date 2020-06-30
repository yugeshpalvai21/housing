class CommercialUnit < ApplicationRecord
    validates :owner, :address, :image, :price, presence: true
end
