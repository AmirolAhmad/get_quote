class Quotation < ActiveRecord::Base
  enum status: [:active, :expired, :closed, :accepted, :rejected]
  extend FriendlyId
  friendly_id :quoteId, use: [:slugged, :finders, :history]

  has_many :items, as: :itemable, dependent: :destroy
  belongs_to :user
  belongs_to :client, foreign_key: "recipientId"
  accepts_nested_attributes_for :items, allow_destroy: true

  after_create :generate_quote_id, :calc_subTotal, :calc_tax, :calc_totalPrice

  default_scope -> { order('quotations.created_at DESC') }

  validates :recipientId, presence: {message: "can't be blank"}
  validates :validUntil, presence: {message: "can't be blank"}

  def generate_quote_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    quote_id = (0...7).map { random[rand(random.length)] }.join

    self.update_attributes(:quoteId => "Q" + quote_id)
  end

  def calc_subTotal
    @total = Item.where(itemable_id: self.id)
    subTotal =  @total.sum(:totalPrice).to_s
    self.update(subTotal: subTotal)
  end

  def calc_tax
    tax = (self.taxRate / 100) * subTotal
    self.update(tax: tax)
  end

  def calc_totalPrice
    totalPrice = subTotal + tax
    self.update(total: totalPrice)
  end

  def should_generate_new_friendly_id?
    quoteId_changed?
  end
end
