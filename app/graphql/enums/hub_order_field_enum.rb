module Enums
  class HubOrderFieldEnum < BaseEnum
    graphql_name 'HubOrderField'
    value('COUNTRY', 'sorts the hubs by country', value: :country_symbol)
    value('NAME', 'sorts the hubs by their names', value: :name)
  end
end
