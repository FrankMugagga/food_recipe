class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @user = User.find(params[:id])
    @inventory = Inventory.new(inventory_params)
  end

  def create
    @user = User.find(params[:id])
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      redirect_to @inventory, notice: 'Inventory was successfull created'
    else
      render :new
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    redirect_to inventories_url, notice: 'Inventory was successfully destroyed'
  end

  private

  def inventory_params
    params.required(:inventory).permit(:name, :user_id)
  end
end
