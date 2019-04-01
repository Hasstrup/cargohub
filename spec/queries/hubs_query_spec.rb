require 'rails_helper'

RSpec.describe HubsQuery do
  before(:all) do
    @country_one = create(:country)
    @country_two = create(:country)
    create_list(:hub, 4, country: @country_one)
    create_list(:hub, 4, country: @country_two)
  end

  context 'with options' do
    context 'without any query values' do
      it 'returns all the records in the database' do
        result = described_class.call({})
        expect(result).to_not be_nil
        expect(result.length).to eq(8)
      end
    end

    context 'with a search text specified' do
      before { create(:hub, name: 'Searchable Text') }
      it 'returns the hub correctly' do
        result = described_class.call(search_text: 'Searchable')
        expect(result).to_not be_empty
        expect(result.first.name).to eq('Searchable Text')
      end
    end

    context 'with filter options' do
      it 'returns the correct hubs with a country specified' do
        query = { country_symbol: @country_one.symbol }
        result = described_class.call(query: query)
        expect(result.length).to eq(4)
        expect(result.first.country).to eq(@country_one)
      end

      it 'returns the hubs with the correct function' do
        query = { function: '1' }
        result = described_class.call(query: query)
        expect(result.length).to be > 0
      end
    end
    context 'order options' do
      it 'orders the results correctly NAME ASC' do
        result = described_class.call(order_by: { field: 'name', direction: 'ASC' })
        expect(result.first.name > result.second.name).to be_falsey
      end

      it 'orders the results correctly NAME DESC' do
        result = described_class.call(order_by: { field: 'name', direction: 'DESC' })
        expect(result.first.name > result.second.name).to be_truthy
      end

      it 'orders the results correctly COUNTRY ASC' do
        result = described_class.call(order_by: { field: 'country_symbol', direction: 'ASC' })
        expect(result.first.country_symbol > result.second.country_symbol).to be_falsey
      end
    end
  end
end
