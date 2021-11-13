Rails.application.routes.draw do
  namespace :api do
    resources :posts
    # routes to correct destination
    get '/posts/:tags/:sortBy/:direction', to: 'posts#get_posts', as: 'Posts'
    get '/posts/:tags', to: 'posts#get_post_by_one_tag'
  end
  namespace :api do
    resources :pings
    get '/ping', to: 'pings#get_ping', as: 'Ping' 
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
