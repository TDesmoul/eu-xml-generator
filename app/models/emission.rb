class Emission < ApplicationRecord
  belongs_to :product

  validates :product_id, uniqueness: { scope: :cas }
end
