class StocksController < ApplicationController

  before_action :current_user_logged_in?

  def search
  end
  

  def get_stock
    @stock_symbol = params[:stock_symbol]
    redirect_to stocks_search_path, notice: "You look up for: #{@stock_symbol}"
  end
  
end
