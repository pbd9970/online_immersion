class ApiKey < ActiveRecord::Base
  belongs_to :user
  validates :value, uniqueness: true

  def self.generate(user_id)
    require 'securerandom'
    create! do |api_key|
      api_key.value = SecureRandom.base64
      api_key.user_id = user_id
    end
  end
end
