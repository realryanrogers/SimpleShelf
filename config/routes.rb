Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :registrations, only: [:create]
  resources :sessions, only: [:create]
  resources :users, only: [:index, :show, :edit], param: :public_user_id do
    resources :medias
  end
  resources :password_resets, only: [:create] do
    collection do
      get ':token', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end
  resources :shelves, only: [:index, :show, :edit, :create]
  resources :books, only: [:index, :show, :edit, :create]
  get '/booksearch', to: "static#booksearch"
  get '/bookdetails', to: "books#bookDetails"
  post '/login', to: "sessions#create"
  root to: "static#home"
  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
