class ChatroomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def index
  end

  def create
  end

  def new
    @supported_languages = Language.all
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
