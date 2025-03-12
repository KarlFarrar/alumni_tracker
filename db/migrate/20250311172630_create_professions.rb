class CreateProfessions < ActiveRecord::Migration[8.0]
  def change
    create_table :professions do |t|
      t.string :title

      t.timestamps
    end
  end
end
