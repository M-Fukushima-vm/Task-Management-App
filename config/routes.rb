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
  
  get          '/users/:user_id/tasks/new', to: 'tasks#new', as: :tasks_new
  post             '/users/:user_id/tasks', to: 'tasks#create', as: :tasks_create
  get              '/users/:user_id/tasks', to: 'tasks#index', as: :tasks_index
  get          '/users/:user_id/tasks/:id', to: 'tasks#show', as: :tasks_show
  get     '/users/:user_id/tasks/:id/edit', to: 'tasks#edit', as: :tasks_edit
  post  '/users/:user_id/tasks/:id/update', to: 'tasks#update', as: :tasks_update
  post '/users/:user_id/tasks/:id/destroy', to: 'tasks#destroy', as: :tasks_destroy
  
  resources :users
end
