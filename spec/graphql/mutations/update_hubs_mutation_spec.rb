require 'rails_helper'
require 'support/graphql_helper.rb'
require 'support/support.rb'

RSpec.describe Mutations::UpdateHubsMutation do
  include TestSupport::FileHelpers
  include TestSupport::GraphQlHelper

  let(:variables) { {} }
  let(:query_string) do
    <<-HERE
    mutation updateHubs {
        updateHubs(input: {}) {
          hubs {
            name
            id
          }
        }
      }
       HERE
  end
  before(:all) { stub_unece_request }
  context 'on success' do
    it 'queues the HubsProcessJob' do
      expect do
        result
      end.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(2)
    end
  end
end
