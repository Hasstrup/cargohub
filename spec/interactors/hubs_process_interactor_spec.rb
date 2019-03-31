require 'rails_helper'
require 'support/support.rb'

RSpec.describe HubsProcessInteractor do
  include TestSupport::FileHelpers
  before { yield_csv_slice }

  describe 'call method' do
    context 'With Valid input' do
      subject(:context) { described_class.call(batch: @csv_slice) }
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'has no errors in the context' do
        expect(context.errors).to be_nil
      end

      it 'imports records into the database' do
        expect { described_class.call(batch: @csv_slice) }.to change { Hub.count }
      end
    end

    context 'with invalid input' do
      it 'fails' do
        expect(described_class.call(batch: {})).to be_a_failure
      end

      it 'fails with error in context' do
        expect(described_class.call(batch: {}).errors).to_not be_nil
      end
    end
  end

  describe 'Private methods' do
    context 'build_attributes_for_hub' do
      it 'yields the correct attribute for a hub' do
        result = described_class.new.send(:build_attributes_for_hub, mock_csv_row)
        expect(result[:locode]).to eq('LA CA')
        expect(result[:name]).to eq('Los California')
        expect(result[:country_symbol]).to eq('LA')
        expect(result[:coordinates]).to_not be_nil
        expect(result[:latitude]).to_not be_nil
        expect(result[:longitude]).to_not be_nil
      end
    end
  end
end
