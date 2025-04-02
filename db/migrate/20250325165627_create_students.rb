class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.integer :uin
      t.string :classification
      t.string :major
      t.string :resumelink
      t.string :email
      t.string :phone
      t.string :biography

      t.timestamps
    end
  end
end
