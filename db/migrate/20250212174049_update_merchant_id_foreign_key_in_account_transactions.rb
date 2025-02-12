class UpdateMerchantIdForeignKeyInAccountTransactions < ActiveRecord::Migration[7.2]
  def change
    # Remove existing foreign key linking merchant_id to customers
    remove_foreign_key :account_transactions, :customers, column: :merchant_id

    # Add new foreign key linking merchant_id to user_cards
    add_foreign_key :account_transactions, :user_cards, column: :merchant_id
  end
end
