module Enums
  class HubFilterEnum < BaseEnum
    graphql_name 'HubFilterEnum'
    value('function', 'filters the hubs by functions', value: :function)
    value('country', 'filters the hubs by their various countries', value: :country)
  end
end
