class CreditCard < ActiveRecord::Base
  Stripe.api_key = Rails.application.secrets.stripe_secret_key
  belongs_to :user
 
  before_validation :set_last_digits
 
  attr_accessor :number
 
  validates :digits, presence: true
  validates :month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :year, presence: true, numericality: { greater_than_or_equal_to: DateTime.now.year }

  after_create :create_credit_card_to_stripe, :retrieve_customer, :update_customer
 
  def set_last_digits
    if number
      number.to_s.gsub!(/\s/,'')
      self.digits ||= number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
    end
  end

  def create_credit_card_to_stripe
    Stripe::Token.create(
      :card => {
        :number => self.digits,
        :exp_month => self.month,
        :exp_year => self.year,
        :cvc => self.cvc
      },
    )
  end

  def retrieve_customer
    Stripe::Customer.retrieve(self.user.customer_id)
  end

  def update_customer
    cu = Stripe::Customer.retrieve(self.user.customer_id)
    cu.description = "Customer for #{self.user.email} %>"
    cu.source = "tok_amex" # obtained with Stripe.js
    cu.save
  end
end