require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'methods' do
    before :each do
      @item_1 = Merchant.create(name: 'Turing')
      @item_2 = Merchant.create(name: 'Ring World')
      @item_3 = Merchant.create(name: 'Bringing joy')
    end
    describe '#search' do
      xit 'returns case insensitive partial matches' do
        expect(Merchant.search("ring")).to eq([@merchant_3, @merchant_2, @merchant_1])
      end
    end
  end
end
