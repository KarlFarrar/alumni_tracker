# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :full_name
      t.string :uid
      t.string :avatar_url 

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
