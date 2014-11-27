class DealsController < ApplicationController

  def index
    @deals = Deal.paginate(:page => params[:page])
    @query = params[:search]
    @search = Sunspot.search(Deal) do |query|  
        query.keywords @query
        puts params[:search] + "ddddddd"
    end  
    @deals = @search.results
  end
end
