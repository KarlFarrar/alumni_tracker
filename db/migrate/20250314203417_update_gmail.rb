class UpdateGmail < ActiveRecord::Migration[8.0]
  def change
    add_column :gmails, :uin, :integer, null: false
    add_foreign_key :gmails, :users, column: :uin, primary_key: :uin
    add_index :gmails, :uin
    if ActiveRecord::Base.connection.column_exists?(:gmails, :full_name)
      remove_column :gmails, :full_name, :string
    end
  end
end
