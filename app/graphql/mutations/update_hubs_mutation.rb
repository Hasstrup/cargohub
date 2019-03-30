module Mutations
  # synchronizes data from UN to the db
  class UpdateHubsMutation < BaseMutation
    argument :input, String, required: false
    field :hubs, Types::HubType.connection_type, null: true

    def resolve
      UpdateHubsInteractor.call
    end
  end
end
