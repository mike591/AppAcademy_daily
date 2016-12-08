class User < ActiveRecord::Base
  attr_reader :password
  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Cat,
    dependent: :destroy

  has_many :requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "CatRentalRequest"

  after_initialize :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bc_obj = BCrypt::Password.new(password_digest)
    bc_obj.is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(128)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(128)
    self.save!
  end

end
