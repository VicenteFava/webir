class AddColumnsToDeals < ActiveRecord::Migration
  def change
  	add_column :deals, :dolars, :boolean
  	add_column :deals, :old_price, :integer
  	execute 'ALTER TABLE deals ALTER COLUMN price TYPE integer USING (price::integer)'
  end
end
