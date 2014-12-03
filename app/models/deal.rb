class Deal < ActiveRecord::Base    
  searchable do  
    text :title, :boost => 5 
    text :info1, :info2, :page
  end 
end
