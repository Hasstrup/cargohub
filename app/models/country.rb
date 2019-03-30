class Country < ApplicationRecord
  has_many :hubs, foreign_key: :country_symbol
end