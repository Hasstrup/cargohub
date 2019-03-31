require 'rails_helper'

RSpec.describe Hub, model: true do
  context 'associations' do
    it { is_expected.to belong_to(:country) }
  end

  context 'Search scopes' do
    it 'responds to near' do
      expect(described_class).to respond_to(:near)
      expect(described_class).to respond_to(:search)
    end
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it 'validates the presence of name' do
      expect(Hub.new({}).valid?).to be_falsey
    end

    it { should validate_presence_of(:locode) }
    it 'validates the presence of locode' do
      expect(Hub.new(name: 'Test name').valid?).to be_falsey
    end

    it 'is valid with a name and locode' do
      expect(Hub.new(name: 'Test name',
                     locode: '12',
                     country_symbol: 'AL').valid?).to be_truthy
    end

    it { should validate_uniqueness_of(:locode) }
    it 'validates uniqueness of locode' do
      described_class.create(name: 'Test Locode',
                             locode: 'Test Locode',
                             country_symbol: 'AI')
      expect(Hub.new(name: 'Testing', locode: 'Test Locode').valid?).to be_falsey
    end
  end
end
