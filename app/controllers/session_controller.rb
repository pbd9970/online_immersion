class SessionController < ApplicationController

  def new
    case params[:provider]
    when "facebook"
      redirect_to '/auth/facebook'
    else
      flash[:warning] = "Sorry, #{params[:provider].capitalize} is not implemented at this time."
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    flash[:info] = 'We hope you enjoyed Online Immersion!'
    redirect_to root_url
  end

  def create
    auth = request.env["omniauth.auth"]
    token = get_token(auth, params[:provider])

    reset_session
    session[:user_id] = token.user.id
    flash[:success] = "Logged in as #{token.user.first_name}"
    redirect_to user_path(token.user)
  end

  def failure
    flash[:danger] = "Authentication error: #{params[:message].humanize}"
    redirect_to root_url
  end

  private

  def get_token(auth, provider)
    # TODO - condense these next two lines? And see about condensing subsequent two lines
    token = Token.find_by(uid: "#{auth['uid']}", provider: "#{auth['provider']}")
    token ||= Token.create(uid: "#{auth['uid']}", provider: "#{auth['provider']}")
    token.token_key = "#{auth['token_key']}"
    token.token_expiration = "#{auth['token_expiration_date']}"
    verify_user(token, auth, provider)
    token.save
    token
  end

  def verify_user(token, auth, provider)
    token.user ||= User.create_with_omniauth(auth, provider)
  end
end
