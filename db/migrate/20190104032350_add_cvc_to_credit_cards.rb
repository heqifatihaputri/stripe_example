class AddCvcToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :cvc, :integer
  end
end
