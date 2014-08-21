class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      user_id = params[:user_id] || params[:id]
      @user = User.find(user_id)
      unless current_user == @user
        flash[:alert] = "Access denied"
        redirect_to logout_path
      end
    end

    def authenticate_user!
      if !current_user
        flash[:alert] = "You need to sign in for access to this page."
        redirect_to root_url
      end
    end

end
