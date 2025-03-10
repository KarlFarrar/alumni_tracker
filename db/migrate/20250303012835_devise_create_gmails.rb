class DeviseCreateGmails < ActiveRecord::Migration[8.0]
  def change
    create_table :gmails do |t|
      t.string :gmail,              null: false, default: ""
      t.string :uid
      t.string :avatar_url

      t.timestamps null: false
    end

    add_index :gmails, :email,                unique: true
  end
end
