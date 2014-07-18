Rails.application.routes.draw do
  devise_for :users
  root 'site#index'
  get '/about' => 'site#about'
  get '/contact' => 'site#contact'
  post '/contact-submit' => 'site#contact_submit', as: :submit_contact
  # public can only access index and show
  resources :menu_items, only: [:index, :show], path: 'our-food'
  get '/our-vegetarian-food' => 'menu_items#vegetarian'
  resources :locations, only: [:index, :show]
  get '/search' => 'search_results#index'
  get '/location-search' => 'search_results#location_search_index'

  # namespacing is pretty much just for organization. also restricts public from doing unwanted stuff.
  namespace :admin do
    get '/' => 'base#index'
    # namespaced so admin can access all menu_items
    resources :menu_items
    resources :locations
  end

end
