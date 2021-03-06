class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessor :remember_token, :activation_token, :reset_token

  mount_uploader :avatar, AvatarUploader

  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  scope :activated, ->{where activated: true}

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true
  validate  :avatar_size

  before_create :create_activation_digest, :generate_auth_token

  has_secure_password

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes! remember_digest: User.digest(self.remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes! remember_digest: nil
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    user_hash = {name: self.name, email: self.email,
      activation_token: self.activation_token}
    UserMailer.account_activation(user_hash).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    self.update_columns reset_digest: User.digest(reset_token),
      reset_send_at: Time.zone.now
  end

  def send_password_reset_email
    user_hash = {name: self.name, email: self.email,
      reset_token: self.reset_token}
    UserMailer.password_reset(user_hash).deliver_now
  end

  def password_reset_expired?
    self.reset_send_at < 2.hours.ago
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def base_resource
    "#{self.name},#{user_path self}"
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def ensure_auth_token!
    return if self.auth_token.present?
    self.auth_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auth_token: random_token)
    end
    self.save
  end

  private
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, I18n.t("should_be_less_5_MB"))
    end
  end

  def generate_auth_token
    self.auth_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auth_token: random_token)
    end
  end

  class << self
    def search q
      where("name LIKE ? or email LIKE ?", "%#{q}%", "%#{q}%")
    end
  end
end
