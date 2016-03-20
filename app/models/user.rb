class User < ActiveRecord::Base

	attr_accessor :remember_token, :activation_token, 
					:reset_token, :reset_send_at

	before_save {self.email = email.downcase}
	before_create :create_activation_digest

	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
										format: {with: VALID_EMAIL_REGEX},
										uniqueness: true
	validates :password, presence: true, length: {minimum: 6}									
	has_secure_password

	def remember_me
		remember_token = User.new_token
		update_attribute :remember_digest, User.digest(remember_token)
	end

	def forget_me
		update_attribute(:remember_digest, nil)
	end

	def activate
		update_attributes(activated: true, activated_at: Time.zone.now)
	end

	def authenticated? remember_digest, remember_token
		BCrypt::Password.new(remember_digest).is_password? remember_token
	end

	def authenticated? attribute
		digest = send("#{attribute}_digest")
		token = send("#{attribute}_token")
		BCrypt::Password.new(digest).is_password? token
	end

	def User.digest string
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)														
	end

	def User.get_user_by_id user_id
  	begin
			user = User.find(user_id)
		rescue
			nil
		end
  end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def create_password_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_send_at, Time.zone.now)
	end
	private

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest self.activation_token
		end
end
