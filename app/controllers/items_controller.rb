class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  wrap_parameters format: {}


  def index
    # if a user id is path, show all items belonging to user or show all items
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end


  private

  def render_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end



end
