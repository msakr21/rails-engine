class Merchant < ApplicationRecord
  has_many :items

  def self.search(search_params)
    where("name ILIKE ?", "%#{search_params}%").order(:name).limit(1).first
  end
end
