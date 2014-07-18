class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  def self.find_or_create_by_omniauth(auth_hash)
    instance = find_or_initialize_by(provider: auth_hash['provider'], uid: auth_hash['uid'])
    instance.save(validate: false)
    instance
  end
end
