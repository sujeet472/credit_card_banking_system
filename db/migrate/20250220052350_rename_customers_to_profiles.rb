class RenameCustomersToProfiles < ActiveRecord::Migration[7.2]
  def change
    # Remove the foreign key safely
    if foreign_key_exists?(:user_cards, column: :customer_id)
      remove_foreign_key :user_cards, column: :customer_id
    end

    if foreign_key_exists?(:customers, :branches)
      remove_foreign_key :customers, :branches
    end

    # Rename table from customers to profiles
    rename_table :customers, :profiles

    # Rename indexes that were created on customers
    if index_exists?(:profiles, :email, name: "index_customers_on_email")
      rename_index :profiles, "index_customers_on_email", "index_profiles_on_email"
    end

    if index_exists?(:profiles, :phone_number, name: "index_customers_on_phone_number")
      rename_index :profiles, "index_customers_on_phone_number", "index_profiles_on_phone_number"
    end

    if index_exists?(:profiles, :discarded_at, name: "index_customers_on_discarded_at")
      rename_index :profiles, "index_customers_on_discarded_at", "index_profiles_on_discarded_at"
    end

    # Rename customer_id to profile_id
    rename_column :user_cards, :customer_id, :profile_id

    # Rename index after renaming the column
    if index_exists?(:user_cards, :profile_id, name: "index_user_cards_on_customer_id")
      rename_index :user_cards, "index_user_cards_on_customer_id", "index_user_cards_on_profile_id"
    end

    # Add the foreign keys again
    add_foreign_key :user_cards, :profiles, column: :profile_id
    add_foreign_key :profiles, :branches, column: :branch_id
  end
end
