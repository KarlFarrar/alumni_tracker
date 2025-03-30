class AddPlacementToAlumnusExperiences < ActiveRecord::Migration[8.0]
  def change
    add_column :alumnus_experiences, :placement, :string
  end
end
