class RemoveExtraColumnsFromExperiences < ActiveRecord::Migration[8.0]
  def change
    remove_column :experiences, :date_interval, :string
    remove_column :experiences, :description, :text
    remove_column :experiences, :recepient_uin, :integer
  end
end
