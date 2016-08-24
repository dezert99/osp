Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :registrations => 'users' }

  resources :guests
  root 'guests#index'

  post 'tokens' => 'tokens#create'
  get 'chat' => 'chats#index'

  get 'notify' => 'notifications#index'
  get 'validate_message' => 'notifications#validate_message'
end
