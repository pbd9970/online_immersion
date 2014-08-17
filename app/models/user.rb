class User < ActiveRecord::Base
  has_many :tokens
  has_many :api_keys
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users

  def self.create_with_omniauth(auth)
    create! do |user|
      case auth[:provider]
      when "facebook", "google_oauth2"
        if auth['info']
          user.first_name = auth['info']['first_name'] || ""
          user.last_name = auth['info']['last_name'] || ""
        end
      when "twitter"
        raise NotImplementedError
      else
        raise NotImplementedError
      end
    end
  end
end
