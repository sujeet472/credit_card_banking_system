class AddDiscardedAtToAllTables < ActiveRecord::Migration[7.2]
  def change
    tables = %i[branches customers credit_cards user_cards account_transactions rewards] # Add all table names here

    tables.each do |table|
      add_column table, :discarded_at, :datetime
      add_index table, :discarded_at # Helps with queries
    end
  end
end
