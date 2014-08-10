class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def show
    @user = User.find(params[:id])
    redirect_to new_user_chatroom_path(@user)
  end

  def update
    @user = User.update(params)
    redirect_to new_chatroom_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.inactive = true
    @user.save
    redirect_to logout_path
  end
end
