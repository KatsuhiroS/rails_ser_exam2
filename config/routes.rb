Rails.application.routes.draw do
  root to: 'blogs#top'
  resources :contacts
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
