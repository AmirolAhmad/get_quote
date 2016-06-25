class Item < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true

  default_scope -> { order('items.created_at ASC') }

  validates :description, presence: {message: "can't be blank"}
  validates :unitPrice, presence: {message: "can't be blank"}
end
