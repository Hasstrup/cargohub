require 'rails_helper'
require 'support/support.rb'

RSpec.describe UneceRetrieveInteractor do
  include TestSupport::FileHelpers

  describe 'call' do
    before { stub_unece_request }
    context 'With a valid response' do
      it 'succeeds' do
        expect(described_class.call).to be_a_success
      end

      it 'does not have any errors in context' do
        expect(described_class.call.errors).to be_nil
      end
    end

    context 'with any http error' do
      before { set_request_failure }

      it 'fails' do
        expect(described_class.call).to be_a_failure
      end

      it 'has errors in context' do
        expect(described_class.call.errors).to_not be_nil
      end
    end
  end
end
