Rails.application.routes.draw do
  resources :students, only: [:create, :destroy]
  resources :schools, only: [] do
    resources :classes, only: [:index] do
      resources :students, only: [:index]
    end
  end
end