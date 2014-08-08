Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.omniauth_facebook_key,
    Rails.application.secrets.omniauth_facebook_secret,
    display: 'popup'
end
