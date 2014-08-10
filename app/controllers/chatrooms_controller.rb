class ChatroomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def index
  end

  def create
    @chatroom = Chatroom.find_by(language_id: params[:language].to_i, matched: false)
    if @chatroom
      @chatroom.update(matched: true)
    else
      @chatroom = Chatroom.create(chatroom_params)
    end
    redirect_to user_chatroom_path(@user, @chatroom)
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

  private

  def chatroom_params
    params.require(:language_id).permit(:matched)
  end
end
