class Stock < ApplicationRecord
  belongs_to :user

  after_create_commit {broadcast_prepend_to "stocks"}
  after_update_commit {broadcast_replace_to "stocks"}
  after_destroy_commit {broadcast_remove_to "stocks"}
  

  #private

    def self.look_up(user_symbol)
      client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_p_token,
        secret_token: Rails.application.credentials.iex_p_token,
        endpoint: 'https://sandbox.iexapis.com/v1')
        
        begin
          {
            symbol: client.company(user_symbol).symbol,
            name: client.company(user_symbol).company_name,
            ceo: client.company(user_symbol).ceo,
            value: client.advanced_stats(user_symbol).enterprise_value_dollar, 
            latest_price: client.quote(user_symbol).latest_price, 
            percent: client.quote(user_symbol).change_percent_s
          }
        rescue
          return nil
        end
    end

    def self.verify(user, symbol)
      user.stocks.where("company_symbol like ?", symbol).first.present?
    end

end
