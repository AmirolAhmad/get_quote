class Profile < ActiveRecord::Base
  belongs_to :user

  validates :firstName, presence: {message: "can't be blank"}, length: { in: 2..250 }
  validates :lastName, presence: {message: "can't be blank"}, length: { in: 2..250 }
end
