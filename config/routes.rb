# frozen_string_literal: true

Rails.application.routes.draw do
  
  devise_for :users

  resources :proponents do
    collection do
      get :calculate_inss
      get :group_calculate_inss
    end
  end

  get 'dashboard', to: 'dashboard#index'
  get 'dashboard/export_csv', to: 'dashboard#export_csv'

  root to: 'dashboard#index'

  mount Sidekiq::Web => "/sidekiq"  # login: user senha: 123
end
