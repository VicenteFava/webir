class Deal < ActiveRecord::Base    
  searchable do  
    text :title, :boost => 5 
    text :info1, :info2, :page
    integer :price
  end

  def self.search query, page, range_id
    if range_id.blank?
      all_deals(query, page)
    elsif range_id == '1'
      less_deals(query, page)
    elsif range_id == '2'
      between_deals(query, page)
    elsif range_id == '3'
      greater_deals(query, page)
    end
  end

  private

  def self.all_deals query, page
    search = Deal.solr_search do
      fulltext query
      paginate :page => page, :per_page => 16
    end
    search
  end

  def self.greater_deals query, page
    search = Deal.solr_search do
      fulltext query
      with(:price).greater_than(1000)
      paginate :page => page, :per_page => 16
    end
    search
  end

  def self.between_deals query, page
    search = Deal.solr_search do
      fulltext query
      with(:price).greater_than(500)
      with(:price).less_than(1000)
      paginate :page => page, :per_page => 16
    end
    search
  end

  def self.less_deals query, page
    search = Deal.solr_search do
      fulltext query
      with(:price).less_than(500)
      paginate :page => page, :per_page => 16
    end
    search
  end

end
