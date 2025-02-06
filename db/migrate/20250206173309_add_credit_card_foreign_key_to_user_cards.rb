class AddCreditCardForeignKeyToUserCards < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :user_cards, :credit_cards, column: :credit_card_id, primary_key: :id
    add_foreign_key :user_cards, :customers, column: :customer_id, primary_key: :id
  end
end
