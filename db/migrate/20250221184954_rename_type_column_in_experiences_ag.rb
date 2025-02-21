class RenameTypeColumnInExperiencesAg < ActiveRecord::Migration[8.0]
  def change
    rename_column :experiences, :type, :experience_type
  end
end
