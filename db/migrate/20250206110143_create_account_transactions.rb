class CreateAccountTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :account_transactions, id: { type: :string, limit: 20 } do |t|
      t.string :user_card_id, limit: 20, null: false
      t.datetime :transaction_date, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :merchant_id, limit: 20, null: false # This is a foreign key referring to `customer_id`
      t.string :location, limit: 100
      t.string :transaction_type, limit: 50, default: "purchase", null: false
      # t.datetime :created_at, null: false
      # t.datetime :updated_at, null: false

      t.timestamps
    end

    # Add foreign key constraint
    add_foreign_key :account_transactions, :customers, column: :merchant_id, primary_key: :id
  end
end
