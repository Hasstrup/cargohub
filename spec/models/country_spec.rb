require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:hubs) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:symbol) }
  end
end
