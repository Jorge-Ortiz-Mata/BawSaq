Rails.application.routes.draw do

  # Stocks controller routes.
  get 'stocks/search'

  # User devise routes.
  devise_for :users

  # Root path.
  root 'pages#home'

end
