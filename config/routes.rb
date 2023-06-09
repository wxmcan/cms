Rails.application.routes.draw do
  resources :coins
  resources :searches
  get 'how-to-buy-:id', to: 'coins#how_to_buy'
  get "how-to-add-:id-to-metamask", to: 'coins#how_to_add'
  mount Spina::Engine => '/'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
