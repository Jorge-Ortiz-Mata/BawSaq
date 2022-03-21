Rails.application.routes.draw do

  # Stocks controller routes.
  get 'stocks/search'
  get 'get_stock', to: 'stocks#get_stock'
  post 'add_stock', to: 'stocks#create'
  get 'stocks', to: 'stocks#stocks'
  delete 'remove_stock', to: 'stocks#destroy'

  # User devise routes.
  devise_for :users

  # Root path.
  root 'pages#home'

end
