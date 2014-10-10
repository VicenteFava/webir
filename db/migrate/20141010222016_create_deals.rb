class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.string :reference
      t.string :photo
      t.string :info1
      t.string :info2
      t.string :price
      t.string :save
      t.string :bought
      t.string :page
      t.string :page_reference

      t.timestamps
    end
  end
end
