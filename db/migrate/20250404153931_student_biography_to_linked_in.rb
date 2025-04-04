class StudentBiographyToLinkedIn < ActiveRecord::Migration[8.0]
  def change
    rename_column :students, :biography, :LinkedIn
  end
end
