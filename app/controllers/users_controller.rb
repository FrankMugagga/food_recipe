class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_public_recipe = @user.recipes.where(public: true)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'user was successfully destroyed'
  end

  private

  def user_params
    params.required(:user).permit(:name, :password, :confrim_password)
  end
end
