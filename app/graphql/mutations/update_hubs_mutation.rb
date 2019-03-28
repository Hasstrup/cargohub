module Mutations
  class UpdateHubsMutation < BaseMutation
    argument :input, String, required: false
    field :hubs, [Types::HubType], null: true

    def resolve
      UpdateHubsInteractor.call
    end
  end
end
