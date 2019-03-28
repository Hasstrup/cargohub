module Types
  class HubFilterInput < BaseInputObject
    graphql_name 'HubFilterInput'
    description 'Options through which hubs can be filtered'

    argument :field, Enums::HubFilterEnum, required: true
  end
end
