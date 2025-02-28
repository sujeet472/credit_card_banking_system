class AddUserIdToProfiles < ActiveRecord::Migration[7.2]
  def change
    # add_foreign_key :profiles, :users, column: :user_id, primary_key: :id
    add_reference :profiles, :users, foreign_key: true
  end
end
