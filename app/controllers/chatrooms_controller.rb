class ChatroomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def create
    @chatroom = Chatroom.find_by(language_id: params[:language_id].to_i, matched: false, concluded: false)
    if @chatroom
      @chatroom = @chatroom.first if @chatroom.respond_to? :first
      unless @chatroom.user_ids.include?(@user.id)
        @user.chatrooms << @chatroom
        @chatroom.update(matched: true)
      end
    else
      @chatroom = @user.chatrooms.create(language_id: params[:language_id])
    end
    redirect_to user_chatroom_path(@user, @chatroom)
  end

  def new
    @supported_languages = Language.all
  end

  def edit
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
