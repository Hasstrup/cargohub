module Types
  class HubType < BaseObject
    graphql_name 'Hub'
    description 'A hub on the application'

    field :id, ID, method: :id, null: false
    field :name, String, null: true
    field :locode, String, null: true
    field :function, String, null: true
    field :coordinates, String, null: true
    field :status, String, null: true
    field :country, Types::CountryType, null: true
  end

  def country
    obj.country
  end
end
