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
    @chatroom = get_user_chatroom(@user, params[:language_id])
    
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
    redirect_to "#{user_chatrooms_path(@user)}/#/#{params[:id]}"
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

  private

  def get_user_chatroom(user, lang)
    # helper vars so that query isn't too long
    chat_args = {language_id: lang.to_i, matched: false, concluded: false}
    cu = :chatroom_users

    #query and immediately update
    chatroom = Chatroom.where(chat_args).joins(cu).where.not(cu => {user_id: user.id}).take
    if chatroom.present?
      chatroom.update(matched: true) 
    else
      chatroom = Chatroom.create(chat_args)
    end
    user.chatrooms << chatroom
    chatroom
  end
end
