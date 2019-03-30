module Types
  class CountryType < BaseObject
    graphql_name 'Country'
    description 'A country that has many hubs'

    field :name, String, null: false
    field :symbol, String, null: false
    field :hubs, [Types::HubType], null: false
  end
end
