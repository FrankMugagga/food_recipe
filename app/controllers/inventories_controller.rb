class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
    @inventory_foods = InventoryFood.all
  end

  def new
    @inventory = current_user.inventories.new
  end

  def create
    @inventory = current_user.inventories.new(inventory_params)
    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory was successfull created'
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
    params.required(:inventory).permit(:name, :description, :user_id)
  end
end
