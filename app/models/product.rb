class Product < ApplicationRecord
  has_many :countries, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :emissions, dependent: :destroy
  has_one :presentation, dependent: :destroy
  has_one :design, dependent: :destroy

  serialize :datas, Hash
end
