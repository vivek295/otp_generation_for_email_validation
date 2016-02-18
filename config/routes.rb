Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'registrations',
        sessions: 'sessions'
      }
  devise_scope :user do
    get 'signup', to: 'registrations#new'
    get 'signin', to: 'sessions#new'
    delete 'logout', to: 'sessions#destroy'
  end
  root 'static_pages#index'
  resources :verifications, only: [:edit,:update]
  post 'verification',to: 'verifications#update'
end
