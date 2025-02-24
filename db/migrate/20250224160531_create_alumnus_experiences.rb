class CreateAlumnusExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :alumnus_experiences do |t|
      t.references :alumnus, null: false, foreign_key: true
      t.references :experience, null: false, foreign_key: true

      t.timestamps
    end
  end
end
