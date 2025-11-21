Rails.application.routes.draw do
  root to: 'home#show'

  namespace :examples do
    resource :file_name, only: :show, controller: :file_name
    resource :render_partial, only: :show, controller: :render_partial
    resources :render_template, only: :show
    resource :respond_to, only: :show, controller: :respond_to
    resource :respond_with, only: :show, controller: :respond_with
  end
end
