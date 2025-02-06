class CreateUserCards < ActiveRecord::Migration[7.2]
  def change
    create_table :user_cards, id: { type: :string, limit: 20 } do |t|
      t.string :credit_card_id, limit: 20, null: false
      t.string :customer_id, limit: 20, null: false
      t.date :issue_date, null: false
      t.date :expiry_date, null: false
      t.integer :cvv, limit: 3, null: false
      t.boolean :is_active, default: true
      t.decimal :available_limit, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :user_cards, :credit_card_id
    add_index :user_cards, :customer_id
  end
end
