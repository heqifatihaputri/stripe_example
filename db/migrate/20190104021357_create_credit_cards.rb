class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :digits
      t.integer :month
      t.integer :year

      t.timestamps null: false
    end
  end
end
