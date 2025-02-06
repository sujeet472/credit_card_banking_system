class AddBranchForeignKeyToCustomers < ActiveRecord::Migration[7.2]
  def change
    # Add foreign key constraint
    add_foreign_key :customers, :branches, column: :branch_id, primary_key: :id
  end
end
