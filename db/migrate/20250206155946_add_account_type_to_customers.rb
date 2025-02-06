class AddAccountTypeToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :account_type, :string, null: false, default: "saving"
  end
end
