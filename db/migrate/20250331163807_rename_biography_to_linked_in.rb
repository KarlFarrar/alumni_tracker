class RenameBiographyToLinkedIn < ActiveRecord::Migration[8.0]
  def change
    rename_column :alumni, :biography, :LinkedIn
  end
end
