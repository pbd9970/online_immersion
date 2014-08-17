class SessionsController < ApplicationController

  def new
    case params[:provider]
    when "facebook"
      redirect_to '/auth/facebook'
    when "google"
      redirect_to '/auth/google_oauth2'
    else
      flash[:warning] = "Sorry, #{params[:provider].capitalize} is not implemented at this time."
      redirect_to root_url
    end
  end

  def destroy
    flash[:info] = 'We hope you enjoyed Online Immersion!' if current_user
    reset_session
    delete_api_key
    redirect_to root_url
  end

  def create
    auth = request.env["omniauth.auth"]
    token = get_token(auth)

    reset_session
    session[:user_id] = token.user.id
    set_api_key(token.user.id)

    flash[:success] = "Logged in as #{token.user.first_name} #{token.user.last_name}"
    redirect_to user_path(token.user)
  end

  def failure
    flash[:danger] = "Authentication error: #{params[:message].humanize}"
    redirect_to root_url
  end

  private

  def set_api_key(user_id)
    api_key = ApiKey.generate(user_id)
    cookies[:api_key] = {
      value: api_key 
      domain: :all
    }
  end

  def delete_api_key
    api_key = ApiKey.find_by(value: cookies[:api_key])
    api_key.delete
    cookies.delete :api_key, domain: :all
  end

  def get_token(auth)
    token_id = {uid: auth['uid'], provider: auth['provider']}
    token = Token.find_by(token_id) || Token.create(token_id)

    get_token_credentials(token, auth['credentials'])
    verify_user(token, auth)
    
    token
  end

  def get_token_credentials(token, credentials)
    token.update(
      {token_key: credentials.token,
       token_expiration: credentials.expires_at})
  end

  def verify_user(token, auth)
    token.user ||= User.create_with_omniauth(auth)
    token.save
  end
end
