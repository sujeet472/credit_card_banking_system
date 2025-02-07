class AddUserCardForeignKeyToAccountTransactions < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :account_transactions, :user_cards, column: :user_card_id, primary_key: :id
  end
end
