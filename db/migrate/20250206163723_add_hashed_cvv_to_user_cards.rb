class AddHashedCvvToUserCards < ActiveRecord::Migration[7.2]
  def change
    add_column :user_cards, :hashed_cvv, :string
    remove_column :user_cards, :cvv, :integer
  end
end
