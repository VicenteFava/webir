class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :deals, :save, :saving
  end
end
