class SessionController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'We hope you enjoyed Online Immersion!'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.tokens.where(provider: auth['provider'],
                      uid: auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Welcome to Online Immersion!'
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end
#end
  def paul
    user = User.find(1)
    reset_session
    session[:user_id] = user.id
    redirect_to users_path(:id)
  end
end
