class User < ActiveRecord::Base
	attr_accessor :activation_token
	require 'bcrypt'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :generate_activation_token
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def generate_activation_token
  	self.activation_token=User.new_token
		self.activation_digest=User.digest(activation_token)
	end
	
	def activate
		update_attribute(:verified,true)
	end

	def authenticated?(password)
		BCrypt::Password.new(encrypted_password).is_password?(password)
	end

	private

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(string)
		cost=ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string,cost: cost)
	end
end
