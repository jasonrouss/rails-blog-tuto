Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :blog_posts do
    resource :cover_image, only: [:destroy], module: :blog_posts
    member do
      post 'like'
      post 'dislike'
    end
  end
  get '/search', to: 'blog_posts#search', as: 'search'

  # get "/blog_posts/new",  to:"blog_posts#new", as: :new_blog_post
  # get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post
  # get "/blog_posts/:id/edit",  to:"blog_posts#edit", as: :edit_blog_post
  # patch "/blog_posts/:id",  to:"blog_posts#update"
  # delete "/blog_posts/:id",  to:"blog_posts#destroy"

  # afterwards because it won't match anwything with id afterwards

  # post "/blog_posts", to: "blog_posts#create", as: :blog_posts

  

  # Defines the root path route ("/")
   root "blog_posts#index"
end
