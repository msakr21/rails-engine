require 'rails_helper'

describe "merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 7)

    get '/api/v1/merchants'
    
    expect(response).to be_successful
    merchants_data = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants_data[:data]

    expect(merchants.length).to eq(7)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by their id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)

    merchant = merchant_data[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(id)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it "can get all items for a given merchant ID" do
    merchant = create(:merchant)

    create_list(:item, 10, merchant_id: merchant.id)
    create_list(:item, 50)

    get "/api/v1/merchants/#{merchant.id}/items"

    items_data = JSON.parse(response.body, symbolize_names: true)
    items = items_data[:data]
    expect(items.length).to eq(10)

    items.each do |item|
      expect(item).to be_a(Hash)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it "can find merchant by name(it returns first, alphabatically, case insensitive result)" do
    merchant_1 = Merchant.create(name: 'Turing')
    merchant_2 = Merchant.create(name: 'Ring World')
    merchant_3 = Merchant.create(name: 'Bringing joy')

    get "/api/v1/merchants/find?name=ring"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_data.length).to eq(1)

    merchant = merchant_data[:data]
    expect(merchant[:id].to_i).to eq(merchant_3.id)
    expect(merchant[:attributes][:name]).to eq('Bringing joy')
  end

  it "it will return a blank result if no match" do
    merchant_1 = Merchant.create(name: 'Turing')
    merchant_2 = Merchant.create(name: 'Ring World')
    merchant_3 = Merchant.create(name: 'Bringing joy')

    get "/api/v1/merchants/find?name=TEST"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_data.length).to eq(1)
    merchant = merchant_data[:data]
    expect(merchant[:data]).to eq(nil)
  end
end