module Types
  class HubType < BaseObject
    graphql_name 'Hub'
    description 'A hub on the application'

    field :id, ID, method: :id, null: false
    field :name, String, null: true
    field :locode, String, null: true
    field :function, String, null: true
    field :latitude, Float, null: true
    field :longitude, Float, null: true
  end
end
