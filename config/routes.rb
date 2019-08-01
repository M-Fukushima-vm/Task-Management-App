Rails.application.routes.draw do
  root            'static_pages#top'
  
  get            '/signup', to: 'users#new'
  
  get             '/login', to: 'sessions#new'
  post            '/login', to: 'sessions#create'
  
  delete         '/logout', to: 'sessions#destroy'
  
  # get           '/users', to: 'users#index'
  # post          '/users', to: 'users#create'
  
  # get       '/users/new', to: 'users#new'
  
  # get  '/users/:id/edit', to: 'users#edit'
  
  get         '/users/:id', to: 'users#show'
  # patch     '/users/:id', to: 'users#update'
  # put       '/users/:id', to: 'users#update'
  # delete    '/users/:id', to: 'users#destroy'
  
  
  
  
  resources :users
end
