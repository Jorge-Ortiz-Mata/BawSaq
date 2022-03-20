class StocksController < ApplicationController

  before_action :current_user_logged_in?

  def search
  end
  

  def get_stock
    if params[:stock_symbol].present?
      @company = Stock.look_up(params[:stock_symbol])
      if !@company.nil?
        render 'stocks/search'
      else
        redirect_to stocks_search_path, alert: "We couldn't find nothing with that symbol."
      end
    else
      redirect_to stocks_search_path, alert: "Enter at least one value."
    end
  end
  
end
