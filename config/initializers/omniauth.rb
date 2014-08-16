Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.omniauth_facebook_key,
    Rails.application.secrets.omniauth_facebook_secret,
    display: 'popup'
  provider :google_oauth2,
    Rails.application.secrets.omniauth_google_client_id,
    Rails.application.secrets.omniauth_google_client_secret,
    display: 'popup'
end
