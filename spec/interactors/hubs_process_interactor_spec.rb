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

    context 'build_attributes_for_country' do
      it 'yields the correct attributes for a country' do
        result = described_class.new.send(:build_attributes_for_country,
                                          ['LA', '.Los Angeles'])
        expect(result[:name]).to eq('Los Angeles')
        expect(result[:symbol]).to eq('LA')
      end
    end

    context 'calculating the latitude' do
      it 'returns an empty string if input is nil' do
        result = described_class.new.send(:lat, nil)
        expect(result).to eq('')
      end

      it 'returns a negative coordinate for S and a positive for N' do
        expect(described_class.new.send(:lat, '4230N')).to be > 0
        expect(described_class.new.send(:lat, '4230S')).to be < 0
      end
    end

    context 'calculating the longitude' do
      it 'returns an empty string if input is nil' do
        result = described_class.new.send(:long, nil)
        expect(result).to eq('')
      end

      it 'returns a negative coordinate for W and a positive for E' do
        expect(described_class.new.send(:long, '42304E')).to be > 0
        expect(described_class.new.send(:long, '42304W')).to be < 0
      end
    end

    context 'converting dms coordinates to decimal degrees' do
      it 'returns the default coordinates if sent nil input' do
        result = described_class.new.send(:coordinates_for, nil)
        expect(result[:coordinates]).to be_nil
        expect(result[:latitude]).to be_nil
        expect(result[:longitude]).to be_nil
      end

      it 'returns the correct coordinates for a dms value' do
        result = described_class.new.send(:coordinates_for, '4230N 00131E')
        expect(result[:coordinates]).to_not be_nil
        expect(result[:latitude]).to_not be_nil
        expect(result[:longitude]).to_not be_nil
      end
    end
  end
end
