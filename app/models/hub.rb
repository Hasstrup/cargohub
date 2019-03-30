class Hub < ApplicationRecord
  belongs_to :route, optional: true
  belongs_to :country, foreign_key: :country_symbol
end
