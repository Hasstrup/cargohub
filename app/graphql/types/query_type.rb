module Types
  # the base query type
  class QueryType < Types::BaseObject
    field :hubs, Types::HubType.connection_type, 'get a list of all the hubs', null: true do
      argument :search_text, String, required: false
      argument :order_by, Inputs::HubOrderInput, required: false
      argument :query, Inputs::HubFilterInput, required: false
    end

    field :countries, Types::CountryType.connection_type, null: true

    def hubs(input = {})
      HubsQuery.call(input)
    end

    def countries
      Country.all
    end
  end
end
