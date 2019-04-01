module Mutations
  # synchronizes data from UN to the db
  class UpdateHubsMutation < BaseMutation
    argument :input, String, required: false
    field :hubs, [Types::HubType], null: true

    def resolve
      result = UneceRetrieveInteractor.call
      if result.success?
        { hubs: [], errors: nil }
      else
        { hubs: [], errors: result.errors }
      end
    end
  end
end
