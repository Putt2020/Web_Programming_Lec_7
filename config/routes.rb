Rails.application.routes.draw do
  resources :likes
  resources :follows
  get 'main', to: 'users#main'
  post 'main', to: 'users#pmain'
  get 'register', to: 'users#register'
  post 'register', to: 'users#regis'
  get 'feed', to: 'posts#feed'
  get 'profile/:name', to: 'follows#profile'
  post 'profile/:name', to: 'follows#Pprofile'
  delete 'profile/:name', to: 'follows#Dprofile'
  get '/new_post', to: 'posts#nPost'
  post '/new_post', to: 'posts#cPost'
  post '/createFeedLike/:postID', to: 'likes#createFeedLike'
  delete '/deleteFeedLike/:likeID', to: 'likes#deleteFeedLike'
  post '/createProfLike/:postID/:profName', to: 'likes#createProfLike'
  delete '/deleteProfLike/:likeID/:profName', to: 'likes#deleteProfLike'

  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
