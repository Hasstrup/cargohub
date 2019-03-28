module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    field :errors, [Types::UserError], null: true
  end
end
