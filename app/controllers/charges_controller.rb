class ChargesController < ApplicationController
  Stripe.api_key = Rails.application.secrets.stripe_secret_key
  before_action :authenticate_user!
  # before_action :find_product

  def new
  end

  def create
    #Amont in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer     => customer.id,
      :amount       => @amount,
      :description  => 'Rails Stripe customer',
      :currency     => 'usd'
    )

    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to root_path
  end
  
  def find_product
    @product = Product.find(params[:product_id])
    # rescue ActiveRecord::RecordNotFound => e
    #   flash[:error] = 'Product not found!'
    # end
  end
end
