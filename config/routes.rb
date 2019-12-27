Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users #, path: 'account', path_names: { sign_in: 'login', sign_out: 'logout'}
  get 'tasks/completed'
  get 'tasks/pending'
  resources :tasks

  get 'settings', to: 'settings#index'
  scope 'settings' do
    resources :tags, :categories
  end

  root 'tasks#index'
end
