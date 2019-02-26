class Product < ApplicationRecord
  has_many :countries
  has_many :ingredients
  has_many :emissions

  serialize :datas, Hash
end
