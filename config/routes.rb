Rails.application.routes.draw do



  # Public routes
  devise_for :users, :path=>"applicant", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :apply

  # Admin routes
  devise_for :admins, :path=>"admin", path_names: { sign_in: 'login', sign_out: 'logout' }
  scope '/admin' do
    resources :logic_questions
    resources :cohorts
    resources :admission_applications do
      resources :comments, only: [:new, :create, :edit, :update, :destroy]
    end
    resources :profile_questions
    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/index', to: 'dashboard#index'
    get 'dashboard/chart/:type(/:time_filter)', to: 'dashboard#chart', as: 'dashboard_chart_data'

    root 'dashboard#index', as: :admin_root_path
  end

  get '/launch', to: 'home#launch'
  get '/live', to: 'home#live'

  root 'home#index'

end
