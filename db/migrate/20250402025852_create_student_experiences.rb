class CreateStudentExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :student_experiences do |t|
      t.date :date_received
      t.text :custom_description
      t.string :placement
      t.references :student, null: false, foreign_key: true
      t.references :experience, null: false, foreign_key: true


      t.timestamps
    end
  end
end
