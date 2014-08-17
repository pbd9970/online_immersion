class ChatroomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def create
    chat_args = {language_id: params[:language_id].to_i, matched: false, concluded: false}
    cu = :chatroom_users
    @chatroom = Chatroom.where(chat_args).joins(cu).where.not(cu => {user_id: 1}).take
    @chatroom.update(matched: true) if @chatroom.present?
    @chatroom ||= Chatroom.create(chat_args)
    @user.chatrooms << @chatroom
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
