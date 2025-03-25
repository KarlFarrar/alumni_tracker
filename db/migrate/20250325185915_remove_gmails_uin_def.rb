class RemoveGmailsUinDef < ActiveRecord::Migration[8.0]
  def change
    change_column_default :gmails, :uin, nil
  end
end
