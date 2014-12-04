class DealsController < ApplicationController

  def index
    @range = [['Menos de 500', '1'], ['Entre 500 y 1000', '2'], ['Mas de 1000', '3']]
    query = params[:search]
    if query.present?
      search = Deal.search(query, params[:page], params[:range_id])
      puts search.inspect
      @deals = search.results
    else
      @deals = Deal.paginate(:page => params[:page])
    end
  end

  def show
  	@deal = Deal.find(params[:id])
  end
end
