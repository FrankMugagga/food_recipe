class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @user = current_user
    @food = @user.foods.new(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created'
    else
      render :new
    end
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def update
    @food = current_user.foods.find(params[:id])

    if @food.update(food_params)
      redirect_to foods_path, notice: 'Food was successfully update'
    else
      render :edit
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url, notice: 'Food was successfully destroyed'
  end

  private

  def food_params
    params.required(:food).permit(:name, :measurement_unit, :price)
  end
end
