class CreateAlumni < ActiveRecord::Migration[8.0]
  def change
    create_table :alumni do |t|
      t.integer :uin
      t.integer :cohort_year
      t.string :team_affiliation
      t.string :profession_title
      t.boolean :availability
      t.string :email
      t.string :phone_number
      t.string :biography

      t.timestamps
    end
  end
end
