class DealsController < ApplicationController

  def index
    @deals = Deal.paginate(page: params[:page])
  end

end
