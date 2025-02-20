class RenameCustomersToProfiles < ActiveRecord::Migration[7.2]
  def change
    rename_table :customers, :profiles

    rename_index :profiles, "index_customers_on_email", "index_profiles_on_email"
    rename_index :profiles, "index_customers_on_phone_number", "index_profiles_on_phone_number"
    rename_index :profiles, "index_customers_on_discarded_at", "index_profiles_on_discarded_at"

    rename_column :user_cards, :customer_id, :profile_id
    rename_index :user_cards, "index_user_cards_on_customer_id", "index_user_cards_on_profile_id"
    
    # remove_foreign_key :user_cards, :customer_id
    add_foreign_key :user_cards, :profiles, column: :profile_id

    remove_foreign_key :profiles, :branches
    add_foreign_key :profiles, :branches, column: :branch_id
  end
end
