Rails.application.routes.draw do
  resource :account, only: [:show]

  resources :sessions, only: [:new, :create]
  get "sessions/fail"
  get "sessions/destroy"

  get "profile/status" => 'profile#profile_status'
  get "profile/qrstatus" => 'profile#profile_qrstatus'

  # Home page
  root 'main#index'
end
