class ChatroomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def index
    begin
      @chatroom = Chatroom.find(session[:chatroom_id])
      render :index
    rescue
      redirect_to new_user_chatroom_path(@user)
    end
  end

  def create
    chat_args = {language_id: params[:language_id].to_i, matched: false, concluded: false}
    cu = :chatroom_users
    @chatroom = Chatroom.where(chat_args).joins(cu).where.not(cu => {user_id: 1}).take
    @chatroom.update(matched: true) if @chatroom.present?
    @chatroom ||= Chatroom.create(chat_args)
    @user.chatrooms << @chatroom
    
    # Give angular control of application
    session[:chatroom_id] = @chatroom.id
    redirect_to "#{user_chatrooms_path(@user)}/#/#{@chatroom.id}"
  end

  def new
    @supported_languages = Language.all
  end

  def show
    # Give angular control of application
    session[:chatroom_id] = params[:id]
    redirect_to "#{user_chatrooms_path(@user)}/#/#{@chatroom.id}"
  end

  def destroy
    chatroom = Chatroom.find(params[:id])
    chatroom.update(concluded: true)
    redirect_to new_user_chatroom_path(@user)
  end

  def ng_view
    @chatroom = Chatroom.find(params[:id])
    if @chatroom
      render :show, layout: false
    else
      redirect_to new_user_chatroom_path(@user)
    end
  end
end
