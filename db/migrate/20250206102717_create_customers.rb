class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers, id: { type: :string, limit: 20 } do |t|
      t.string :first_name, limit: 50, null: false
      t.string :last_name, limit: 50, null: false
      t.date :date_of_birth, null: false
      t.string :email, limit: 100, null: false
      t.integer :phone_number, limit: 15, null: false
      t.text :address, null: false
      t.string :branch_id, limit: 20
      t.string :profile_image, limit: 255 # New optional field

      t.timestamps
    end

    add_index :customers, :email, unique: true
    add_index :customers, :phone_number, unique: true
  end
end
