class Quotation < ActiveRecord::Base
  enum status: [:active, :expired, :closed, :accepted, :rejected]
  belongs_to :user
  belongs_to :client, foreign_key: "recipientId"

  after_create :generate_quote_id

  default_scope -> { order('quotations.created_at DESC') }

  validates :recipientId, presence: {message: "can't be blank"}

  def generate_quote_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    quote_id = (0...7).map { random[rand(random.length)] }.join

    self.update_attributes(:quoteId => "Q" + quote_id)
  end
end
