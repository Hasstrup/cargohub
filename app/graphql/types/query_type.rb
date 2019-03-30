module Types
  # the base query type
  class QueryType < Types::BaseObject
    field :hubs, [Types::HubType], 'get a list of all the hubs', null: true do
      argument :search_text, String, required: false
      argument :order_by, Inputs::HubOrderInput, required: false
      argument :filter_by, Inputs::HubFilterInput, required: false
      argument :coordinates, String, required: false
    end

    def hubs(arguments)
      result = HubsQuery.call(arguments)
      { hubs: result }
    end
  end
end
