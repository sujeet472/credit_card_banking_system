class CreateCreditCards < ActiveRecord::Migration[7.2]
  def change
    create_table :credit_cards, id: { type: :string, limit: 20 } do |t|
      t.string :type_of_card, null: false
      t.decimal :credit_limit, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
