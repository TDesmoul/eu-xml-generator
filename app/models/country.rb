class Country < ApplicationRecord
  belongs_to :product

  validates :product_id, uniqueness: { scope: :code }
end
