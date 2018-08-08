Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'top#index'

  namespace :api do
    resources :questions, only: %i(index) do
      member do
        post :answer, to: 'questions#answer'
      end
    end
  end

  namespace :admin do
    root to: 'questions#index'
    resources :questions, expect: %i(show)
  end
end
