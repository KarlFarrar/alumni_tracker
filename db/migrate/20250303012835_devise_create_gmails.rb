

class DeviseCreateGmails < ActiveRecord::Migration[8.0]
  def change
    create_table :gmails do |t|
      t.string :email,              null: false, default: ""
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      

      t.timestamps null: false
    end

    add_index :gmails, :email,                unique: true
  end
end
