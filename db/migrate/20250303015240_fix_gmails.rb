class FixGmails < ActiveRecord::Migration[8.0]
  def change
    remove_column :gmails, :full__name
    add_column :gmails, :full_name, :string
  end
end
