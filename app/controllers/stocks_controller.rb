class StocksController < ApplicationController

  before_action :current_user_logged_in?

  def search
  end

  def stocks
    @stocks = current_user.stocks
  end

  def create
    @company = params[:company]
    @stock = Stock.new(company_symbol: @company[:symbol], company_name: @company[:name], company_ceo: @company[:ceo], company_value_usd: @company[:value], company_latest_price: @company[:latest_price], company_percent: @company[:percent])
    @stock.user_id = current_user.id
    @stock.save
    redirect_to stocks_path, notice: "You started to track: #{@company[:name]}"
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

  def destroy
      @stock = Stock.find(params[:stock])
      @stock.destroy
      redirect_to stocks_path, alert: "You've deleted: #{@stock.company_symbol}, #{@stock.company_name}"
  end
  
end
