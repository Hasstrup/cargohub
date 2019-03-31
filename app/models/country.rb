class Country < ApplicationRecord
  has_many :hubs, foreign_key: :country_symbol, primary_key: :symbol

  validates_presence_of :name, :symbol
end
