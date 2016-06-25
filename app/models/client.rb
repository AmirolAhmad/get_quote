class Client < ActiveRecord::Base
  extend FriendlyId
  friendly_id :clientId, use: [:slugged, :finders, :history]

  belongs_to :user
  has_many :quotations, foreign_key: "recipientId"

  after_create :generate_client_id

  default_scope -> { order('clients.created_at DESC') }

  validates :contactPerson, presence: {message: "can't be blank"}, length: { in: 2..250 }
  validates :companyName, presence: {message: "can't be blank"}, length: { in: 2..250 }
  validates :companyAddress, presence: {message: "can't be blank"}
  validates :email, presence: {message: "can't be blank"}
  validates :phone, presence: {message: "can't be blank"}, length: { maximum: 12,
    too_long: "%{count} characters is the maximum allowed" }, numericality: true

  def generate_client_id
    random_char = ['A'..'Z'].map { |i| i.to_a }.flatten
    random_num = ['1'..'9'].map { |i| i.to_a }.flatten

    char = (0...2).map { random_char[rand(random_char.length)] }.join
    num = (0...6).map { random_num[rand(random_num.length)] }.join

    self.update_attributes(:clientId => char + num)
  end

  def recipient
    "#{contactPerson} (#{companyName}) - #{clientId}"
  end

  def should_generate_new_friendly_id?
    clientId_changed?
  end
end
