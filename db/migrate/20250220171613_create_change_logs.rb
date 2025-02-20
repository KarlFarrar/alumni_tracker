class CreateChangeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :change_logs do |t|
      t.string :user
      t.string :action
      t.string :record_type
      t.integer :record_id
      t.text :change_details

      t.timestamps
    end
  end
end
