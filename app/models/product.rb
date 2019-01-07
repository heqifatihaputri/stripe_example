class Product < ActiveRecord::Base
	validates :name,  presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  belongs_to :user
  # has_many :uploads
  has_attached_file :image, :styles => { :medium => "100x100>",:thumb => "100x100>" }
	
	validates_attachment 	:image, 
				:presence => true,
				:content_type => { :content_type => /\Aimage\/.*\Z/ },
				:size => { :less_than => 1.megabyte }
 
  def price_in_cents
    (price * 100).to_i
  end
end
