Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'account', to: 'account#index'
  get 'account/removal', to: 'account#cancel'
  devise_for :users, path: 'account', path_names: {
    sign_in: 'login',
    sign_out: 'session',
  }, controllers: {
    registrations: 'users/registrations',
  }
  get 'tasks/completed'
  get 'tasks/pending'
  post 'tasks/filter'
  get 'tasks/by-category/:category_id', to: 'tasks#by_category', as: 'tasks_by_category'
  get 'tasks/by-tags/:tag_ids', to: 'tasks#by_tags', as: 'tasks_by_tags'
  get 'tasks/by-category/:category_id/by-tags/:tag_ids', to: 'tasks#by_category_and_tags', as: 'tasks_by_category_and_tags'
  get 'tasks/search(/:keyword)', to: 'tasks#search', as: 'tasks_search'
  resources :tasks

  get 'settings', to: 'settings#index'
  scope 'settings' do
    resources :tags, :categories
  end

  root 'tasks#index'
end
