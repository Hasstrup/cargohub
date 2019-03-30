class Hub < ApplicationRecord
  belongs_to :route, optional: true
  belongs_to :country, foreign_key: :country_symbol, primary_key: :symbol

  include PgSearch
  pg_search_scope :search, against: %i[locode name]
end
