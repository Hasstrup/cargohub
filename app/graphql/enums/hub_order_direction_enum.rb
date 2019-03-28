module Enums
  class HubOrderDirectionEnum < BaseEnum
    graphql_name 'HubOrderDirection'
    value('ASC', 'sorts the hubs in ascending order', value: :asc)
    value('DESC', 'sorts the hubs in descending order', value: :desc)
  end
  end
