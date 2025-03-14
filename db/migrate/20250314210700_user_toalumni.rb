class UserToalumni < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :alumni, :users, column: :uin, primary_key: :uin
    add_index :alumni, :uin, unique: true  # Ensure one-to-one relationship
  end
end
