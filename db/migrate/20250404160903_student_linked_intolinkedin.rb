class StudentLinkedIntolinkedin < ActiveRecord::Migration[8.0]
  def change
    rename_column :students, :LinkedIn, :linkedin
  end
end
