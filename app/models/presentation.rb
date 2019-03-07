class Presentation < ApplicationRecord
  belongs_to :product

  validates :product_id, uniqueness: true

  serialize :datas, Hash
end
