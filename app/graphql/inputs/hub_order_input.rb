module Inputs
  class HubOrderInput < BaseInputObject
    graphql_name 'HubOrderInput'
    description 'Options through which hubs can be ordered'

    argument :field, Enums::HubOrderFieldEnum, required: true
    argument :direction, Enums::HubOrderDirectionEnum, required: true
  end
end
