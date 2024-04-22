class InventoryFoodsController < ApplicationController
  before_action :set_inventory
  before_action :set_inventory_food, only: [:destroy]

  def index
    @inventory_foods = InventoryFood.all   
  end

  def show
    @inventory_food = InventoryFood.find(params[:id])    
  end

  def new
    @inventory_food = @inventory.inventory_foods.new
  end

  def create
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)
    if @inventory_food.save
      redirect_to inventory_path(@inventory), notice: 'Food was successfully create'
    else
      render :new
    end
  end

  def destroy
    @inventory_food.destroy
    redirect_to inventory_path(@inventory), notice: 'Inventory was successfully deleted'
  end
  
  private

  def set_inventory
    @inventory = current_user.inventories.find_by(id: params[:inventory_id])
    unless @inventory
      redirect_to inventories_path, alert: 'Inventory not found'
    end
  end

  def set_inventory_food
    @inventory_food = @inventory.inventory_foods.find(params[:id])
  end

  def inventory_food_params
    params.require(:inventory_food).permit(:food_id, :quantity)
  end

end
