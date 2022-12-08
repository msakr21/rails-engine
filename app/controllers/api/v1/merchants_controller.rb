class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    if params[:merchant_id].nil?
      render json: Merchant.find(params[:id])
    else
      render json: Item.find(params[:id]).merchant
    end
  end
end