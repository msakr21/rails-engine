class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    if Merchant.search(params[:name]).present?
      render json: MerchantSerializer.new(Merchant.search(params[:name]))
    else
      render json: {data: {}}
    end
  end
end