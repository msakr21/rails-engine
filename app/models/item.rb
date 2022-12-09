class Item < ApplicationRecord
  belongs_to :merchant

  # def self.search_name(search_params)
  #   where("name ILIKE ?", "%#{search_params}%").order(:name)
  # end

  # def self.search_one_price(search_params, value)
  #   where("price >= ?", value1).order(:price search_params, :name)
  # end

  # def self.search_both_price(search_params1, value1, search_params2, value2)
  #   where("price >= ? AND price <= ?", value1, value2).order(:name)
  # end
end
