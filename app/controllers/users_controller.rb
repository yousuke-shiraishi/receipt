class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    return redirect_to new_user_path unless user_params
    current_user.update(user_params)
    redirect_to root_path
  end

  private

  def user_params
    if params[:user]
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    else
      false
    end
  end
end
