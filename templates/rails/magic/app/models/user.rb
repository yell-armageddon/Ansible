require 'bcrypt'

class User < ActiveRecord::Base
  	has_many :decks #, :class_name => 'Decks'
	has_many :revs
	has_many :comments

# attr_accessor :reset_token, :remember_digest , :remember_token
 attr_accessor :reset_token, :activation_token , :remember_token

	before_save { self.email = email.downcase }

# validates :name, presence: true, length: { maximum: 50}, uniqueness: {case_sensitive: false}
 validates :name, presence: true, uniqueness: true
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates :email, presence: true, length: { maximum: 255 },
          format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

 has_secure_password
 validates :password, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  # Returns true if the given token matches the digest.
 # def authenticated?(remember_token)
 #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
 # end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
#    self.activation_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver!
  end

 def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

   def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

	
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
