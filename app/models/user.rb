class User < ActiveRecord::Base
  has_many :tokens

  def self.create_with_omniauth(auth, provider)
    create! do |user|
      case provider.to_sym
      when :facebook
        if auth['info']
          user.first_name = auth['info']['first_name'] || ""
          user.last_name = auth['info']['last_name'] || ""
        end
      when :twitter
        raise NotImplementedError
      else
        raise NotImplementedError
      end
    end
  end
end
