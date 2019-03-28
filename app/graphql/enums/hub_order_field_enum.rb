module Enums
  class HubOrderFieldEnum < BaseEnum
    graphql_name 'HubOrderField'
    value('COUNTRY', 'sorts the hubs by country', value: :country)
    value('DATE_ADDED', 'sorts the hubs by the date they were added to UNECE', value: :date_added)
  end
end
