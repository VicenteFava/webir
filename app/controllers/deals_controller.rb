class DealsController < ApplicationController

  def index
    @deals = Deal.paginate(:page => params[:page])
    @query = params[:search]
    if !@query.nil?
      @search = Sunspot.search(Deal) do |query|  
          query.keywords @query
      end  
      @deals = @search.results
    end

    filter = params[:base]
    if filter.present?
      @deals = @deals.where('price > ?', filter)
    end
    @deals
    filter = params[:limit]
    if filter.present?
      @deals = @deals.where('price < ?', filter)
    end
    @deals
  end

  def show
  	@deal = Deal.find(params[:id])
  	@deal
  end
end
