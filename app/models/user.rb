class User < ActiveRecord::Base
  has_many :tokens

  def self.create_with_omniauth(auth)
    create! do |user|
      user.tokens.new.provider = auth['provider']
      user.tokens.new.uid = auth['uid']
      user.tokens.save
      if auth['info']
        require 'pry-debugger'
        binding.pry
        user.first_name = auth['info']['name'] || ""
      end
    end
  end
end
