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

    resources :admins, path: 'employees' do
      member do
        patch 'update_password'
        get 'edit_password'
      end
    end

    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/index', to: 'dashboard#index'
    get 'dashboard/chart/:type(/:time_filter)', to: 'dashboard#chart', as: 'dashboard_chart_data'
    get 'cohort/chart/:cohort_id/:type(/:time_filter)', to: 'cohorts#chart', as: 'cohort_chart_data'

    root 'dashboard#index', as: :admin_root_path
  end

  get '/launch', to: 'home#launch'
  get '/live', to: 'home#live'
  get '/jobs', to: 'home#jobs'
  get '/volunteer', to: 'home#volunteer', as: 'volunteer'
  get '/catalog', to: redirect('/assets/documents/catalog.pdf')
  get '/conduct', to: redirect('/assets/documents/conduct_guide.pdf')
  get '/program', to: redirect('/assets/documents/program_description.pdf')

  root 'home#index'

end
