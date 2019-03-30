module Inputs
  class HubFilterInput < BaseInputObject
    graphql_name 'HubFilterInput'
    description 'Options through which hubs can be filtered'

    argument :name, String, required: false
    argument :function, String, required: false
    argument :country_symbol, String, required: false
    argument :address, String, required: false
  end
end
