class Hub < ApplicationRecord
  belongs_to :country, foreign_key: :country_symbol,
                       primary_key: :symbol, optional: true

  validates_presence_of :name, :locode
  validates_uniqueness_of :locode

  include PgSearch

  reverse_geocoded_by :latitude, :longitude
  pg_search_scope :search, against: %i[locode name]
end
