require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items)}
  end

  describe 'methods' do
    before :each do
      @merchant_1 = Merchant.create(name: 'Turing')
      @merchant_2 = Merchant.create(name: 'Ring World')
      @merchant_3 = Merchant.create(name: 'Bringing joy')
    end
    describe '#search' do
      it 'returns case insensitive partial matches' do
        expect(Merchant.search("ring")).to eq(@merchant_3)
      end
    end
  end
end
