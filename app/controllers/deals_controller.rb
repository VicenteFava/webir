class DealsController < ApplicationController

  def index
    @range = [['Menos de 500', '1'], ['Entre 500 y 1000', '2'], ['Mas de 1000', '3']]
    query = params[:search]
    if query.present?
      search = Deal.search(query, params[:page], params[:range_id])
      @deals =  search.results
    elsif params[:range_id].present?
      search = Deal.search_by_price(params[:page], params[:range_id])
      @deals = search.paginate(:page => params[:page])
    else
       @deals = Deal.paginate(:page => params[:page])
    end
    @deals
  end

  def show
  	@deal = Deal.find(params[:id])
  end
end
