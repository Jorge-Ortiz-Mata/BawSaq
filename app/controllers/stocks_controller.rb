class StocksController < ApplicationController

  before_action :current_user_logged_in?

  def search
  end

  def stocks
    @stocks = current_user.stocks
  end

  def create
    @company = params[:company]
    @stock = current_user.stocks.new(company_symbol: @company[:symbol], company_name: @company[:name], company_ceo: @company[:ceo], company_value_usd: @company[:value], company_latest_price: @company[:latest_price], company_percent: @company[:percent])
    @stock.save
    redirect_to stocks_path, notice: "You started to track: #{@company[:name]}"
  end

  def get_prices
    @stocks = current_user.stocks
    @stock = Stock.find(params[:stock])
    @stock_prices = Stock.get_prices(@stock.company_symbol)
    @stock_max = @stock_prices.max() + 1
    @stock_min = @stock_prices.min() - 1
    render 'stocks/stocks'
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

  def update
    @stock_update = Stock.find(params[:stock])
    @company = Stock.look_up(@stock_update.company_symbol)
    @stock_update.update(company_symbol: @company[:symbol], company_name: @company[:name], company_ceo: @company[:ceo], company_value_usd: @company[:value], company_latest_price: @company[:latest_price], company_percent: @company[:percent])
    redirect_to stocks_path, notice: "Stock updated. Stock: #{@stock_update.company_symbol}"
  end

  def destroy
      @stock = Stock.find(params[:stock])
      @stock.destroy
      redirect_to stocks_path, alert: "You've deleted: #{@stock.company_symbol}, #{@stock.company_name}"
  end
  
end
