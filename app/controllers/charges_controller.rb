class ChargesController < ApplicationController
  Stripe.api_key = Rails.application.secrets.stripe_secret_key
  before_action :authenticate_user!
  before_action :find_product

  def new
  end

  def create
    # @charge = Charge.new
    charge = Stripe::Charge.create(
      :customer     => current_user.customer_id,
      :amount       => @product.price_in_cents,
      :description  => 'Rails Stripe customer',
      :currency     => 'usd'
    )

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Payment was successfully' }
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to root_path
  end

  private
  
  def find_product
    @product = Product.find(params[:product_id])
  end
end
