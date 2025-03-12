class CreateAlumnusProfessions < ActiveRecord::Migration[8.0]
  def change
    create_table :alumnus_professions do |t|
      t.references :alumnus, null: false, foreign_key: true
      t.references :profession, null: false, foreign_key: true
      t.string :field

      t.timestamps
    end
  end
end
