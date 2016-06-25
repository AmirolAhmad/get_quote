class Profile < ActiveRecord::Base
  belongs_to :user

  validates :firstName, presence: {message: "can't be blank"}, length: { in: 2..250 }
  validates :lastName, presence: {message: "can't be blank"}, length: { in: 2..250 }
  validates :phoneNumber, presence: {message: "can't be blank"}, length: { maximum: 12,
    too_long: "%{count} characters is the maximum allowed" }, numericality: true
  validates :csPhoneNumber, presence: {message: "can't be blank"}, length: { maximum: 12,
      too_long: "%{count} characters is the maximum allowed" }, numericality: true
end
