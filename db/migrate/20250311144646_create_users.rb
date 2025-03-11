class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: false do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false 
      t.string :middle_initial, default: ""
      t.integer :uin, primary_key: true
      t.string :status, default: ""
      t.boolean :isAdmin, default: false
      t.timestamps
    end
  end
end
