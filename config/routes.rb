Rails.application.routes.draw do
  #ルーティング確認  http://localhost:3000/rails/info/routes

  namespace :api do
    resource :users, only: [:create, :update, :destroy]
    resources :users, only: [:index, :show]
    resource :session, only: [:create, :edit, :update, :destroy]
    resources :session, only: [:index, :show]
    post 'auth/jwt/create', to: 'sessions#create' 
    post 'register', to: 'users#create'

    get 'list-post', to: 'posts#index'
    get 'detail-post/:id', to: 'posts#show'

    get 'list-task', to: 'tasks#index'
    get 'detail-task/:id', to: 'tasks#show'
    
    resource :posts, only: [:create, :update, :destroy]
    resources :posts, only: [:index, :show]
    resource :tasks, only: [:create]
    resources :tasks, only: [:index, :show, :update, :destroy]

  end

  get 'posts' , to: 'posts#index'
  get 'posts/:id', to: 'posts#index'

  post 'posts', to: 'posts#create'
  patch 'posts', to: 'posts#update'
  delete 'posts', to: 'posts#delete'

  get 'tasks' , to: 'tasks#index'
  get 'tasks/:id', to: 'tasks#index'

  post 'tasks', to: 'tasks#create'
  patch 'tasks', to: 'tasks#update'
  delete 'tasks', to: 'tasks#delete'
end