module Types
  class MutationType < BaseObject
    graphql_name 'Mutation'
    field :update_hubs, mutation: Mutations::UpdateHubsMutation
  end
end
