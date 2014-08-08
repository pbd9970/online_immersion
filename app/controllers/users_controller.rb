class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def create
    @user = User.create(params)
  end

  def new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    redirect_to new_chatrooms_path
  end

  def update
    @user = User.update(params)
    redirect_to new_chatrooms_path
  end

  def destroy
    
  end
end
