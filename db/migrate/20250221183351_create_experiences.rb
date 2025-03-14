class CreateExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :experiences do |t|
      t.string :title
      t.string :type
      t.string :date_interval
      t.text :description
      t.integer :recepient_uin

      t.timestamps
    end
  end
end
