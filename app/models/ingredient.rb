class Ingredient < ApplicationRecord
  belongs_to :product

  validates :product_id, uniqueness: { scope: :cas }
end
