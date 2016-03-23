Rails.application.routes.draw do

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  # nested comment
  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

  resources :users do
    member do
      get :following, :followers
    end
    resources :addresses,         only: [:new, :edit, :create, :delete, :update]
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:show, :create, :destroy]
  resources :comments,            only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

end
