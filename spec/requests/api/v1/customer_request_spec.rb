require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 7)

    get '/api/v1/customers'
    
    expect(response).to be_successful
    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers.length).to eq(7)

    customers.each do |customer|
      expect(customer).to have_key(:id)
      expect(customer[:id]).to be_an(Integer)

      expect(customer).to have_key(:first_name)
      expect(customer[:first_name]).to be_a(String)

      expect(customer).to have_key(:last_name)
      expect(customer[:last_name]).to be_a(String)
    end
  end

  it "can get one customer by their id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(customer).to have_key(:id)
    expect(customer[:id]).to eq(id)

    expect(customer).to have_key(:first_name)
    expect(customer[:first_name]).to be_a(String)

    expect(customer).to have_key(:last_name)
    expect(customer[:last_name]).to be_a(String)
  end
end