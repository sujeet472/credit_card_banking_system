class CreateRewards < ActiveRecord::Migration[7.2]
  def change
    create_table :rewards, id: { type: :string, limit: 20 } do |t|
      t.string :account_transaction_id, limit: 20, null: false
      t.string :user_card_id, limit: 20, null: false
      t.integer :points_earned, null: false
      t.integer :points_redeemed, null: false
      t.datetime :last_updated, default: -> { "CURRENT_TIMESTAMP" }
      
      t.timestamps
    end

    # Add foreign key constraints
    add_foreign_key :rewards, :account_transactions, column: :account_transaction_id, primary_key: :id
    add_foreign_key :rewards, :user_cards, column: :user_card_id, primary_key: :id

    # Add indexes to improve query performance
    add_index :rewards, :account_transaction_id
    add_index :rewards, :user_card_id
  end
end
