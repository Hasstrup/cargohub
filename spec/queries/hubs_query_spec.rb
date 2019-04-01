require 'rails_helper'

RSpec.describe HubsQuery do
  let(:country_one) { create(:country) }
  let(:country_two) { create(:country) }

  before(:all) do
    create_list(:hub, 4, country: country_one)
    create_list(:hub, 4, country: country_two)
  end
  describe 'with options' do
    context 'without any query values' do
      it 'returns all the records in the database' do
        result = described_class.call({})
        expect(result).to_not be_nil
        expect(result.length).to eq(8)
      end
    end
  end
end
