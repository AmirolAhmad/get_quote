class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :profile, dependent: :destroy
  has_many :clients
  has_many :quotations
  accepts_nested_attributes_for :profile, update_only: true, allow_destroy: true

  after_create :create_profile

  attr_accessor :login
  validate :validate_username
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
