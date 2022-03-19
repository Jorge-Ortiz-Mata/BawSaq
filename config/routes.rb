Rails.application.routes.draw do

  # Stocks controller routes.
  get 'stocks/search'
  get 'get_stock', to: 'stocks#get_stock'

  # User devise routes.
  devise_for :users

  # Root path.
  root 'pages#home'

end
