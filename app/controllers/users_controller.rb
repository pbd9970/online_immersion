class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def edit
  end

  def show
    redirect_to new_user_chatroom_path(@user)
  end

  def update
    #@user.update(params)
    redirect_to new_user_chatroom_path(@user)
  end

  def destroy
    @user.update(inactive: true)
    redirect_to logout_path
  end
end
