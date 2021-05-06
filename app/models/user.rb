require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 28000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_REGEX = /\A[a-z0-9\_]+\.?[a-z0-9\_.]+@[a-z0-9\.]+\.[a-z]+\z/
  USERNAME_REGEX = /\A\w+\z/
  COLOR_REGEX = /\A#(\h{3}|\h{6})\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, :color, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: USERNAME_REGEX }
  validates :color, length: { maximum: 7 }
  validates :color, format: { with: COLOR_REGEX }
  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_validation :downcase_username_and_email
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack("H*")[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def downcase_username_and_email
    username&.downcase!
    email&.downcase!
  end
end
