class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      render json: ItemSerializer.new(Item.all)
    else
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: MerchantItemSerializer.new(Item.create(item_params)), status: 201
  end

  def update
    if Item.where(id: params[:id]).exists? && Item.update(params[:id], item_params).save
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render json: { error: 'Does not exist' }, status: :not_found
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end