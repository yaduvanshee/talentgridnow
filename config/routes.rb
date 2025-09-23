Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "short_urls#new"
  resources :short_urls, only: [:new, :create, :show]

  get '/:slug', to: 'short_urls#redirect', as: :short

  namespace :api do
    namespace :v1 do
      resources :short_urls, only: [:create]
    end
  end
end
