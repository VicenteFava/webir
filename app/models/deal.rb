class Deal < ActiveRecord::Base

  searchable do  
    text :title  
  end  
end
