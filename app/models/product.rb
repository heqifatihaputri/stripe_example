class Product < ActiveRecord::Base
	validates :name,  presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  belongs_to :user
 
  def price_in_cents
    (price * 100).to_i
  end
end