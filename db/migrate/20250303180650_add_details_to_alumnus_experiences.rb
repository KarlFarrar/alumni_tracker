class AddDetailsToAlumnusExperiences < ActiveRecord::Migration[8.0]
  def change
    add_column :alumnus_experiences, :date_received, :date
    add_column :alumnus_experiences, :custom_description, :text
  end
end
