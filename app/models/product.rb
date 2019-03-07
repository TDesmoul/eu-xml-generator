class Product < ApplicationRecord
  has_many :countries
  has_many :ingredients
  has_many :emissions
  has_one :presentation
  has_one :design

  serialize :datas, Hash
end
