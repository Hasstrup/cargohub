module Mutations
  # synchronizes data from UN to the db
  class UpdateHubsMutation < BaseMutation
    argument :input, String, required: false
    field :hubs, [Types::HubType], null: true

    def resolve
      UpdateHubsInteractor.call
      {
        hubs: []
      }
    end
  end
end
