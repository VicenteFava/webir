class AddFilterPriceToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :filter_price, :integer
  end
end
