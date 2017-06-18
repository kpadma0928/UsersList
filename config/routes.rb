Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :roles
  put "hide_roles" => "roles#hide_roles", as: :hide_roles
  get 'role_users' => 'users#role_users'
  resources :users
end
