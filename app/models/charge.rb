# class Charge < ActiveRecord::Base
#   Stripe.api_key = Rails.application.secrets.stripe_secret_key

#   # cattr_accessor :current_user
#   binding.pry
#   charge = Stripe::Charge.create(
#       :customer     => self.user.customer_id,
#       :amount       => @product.price_in_cents,
#       :description  => 'Rails Stripe customer',
#       :currency     => 'usd'
#     )
# end