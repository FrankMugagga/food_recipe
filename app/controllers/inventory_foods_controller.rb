class InventoryFoodsController < ApplicationController
    def index
        @inventory_foods = InventroyFood.all
    end
  
    def show
        @inventory_food = InventroyFood.find(params[:id])
    end
  
    def new
        @inventory_food = InventoryFood.new
    end
  
    def create
        @inventory_food = InventoryFood.new(inventory_food_params)

        if @inventory_food.save
            redirect_to @inventory_food, notice: 'Inventory food was successfully created'
        else
            render :new
        end
    end
  
    def destroy
        @inventory_food = InventoryFood.find(params[:id])        
        @inventory_food.destroy
        redirect_to inventory_foods_url, notice: 'Inventory food was successfully destroyed'
    end

    private

    def inventory_food_params
        params.require(:inventory_food).permit(:quantity, :inventory_id, :food_id)
    end

end
