class CreateBranches < ActiveRecord::Migration[7.2]
  def change
    create_table :branches, id: { type: :string } do |t|
      t.string :branch_name, limit: 50, null: false
      t.text :branch_address, null: false
      t.string :branch_manager, limit: 50, null: false
      t.string :branch_phone, limit: 15, null: false
      t.string :branch_email, limit: 100, null: false

      t.timestamps
    end

    add_index :branches, :branch_email, unique: true
    add_index :branches, :branch_phone, unique: true
  end
end
