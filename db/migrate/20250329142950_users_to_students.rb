class UsersToStudents < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :students, :users, column: :uin, primary_key: :uin
    add_index :students, :uin, unique: true  # Ensure one-to-one relationship
  end
end
