Rails.application.routes.draw do



  # Public routes
  devise_for :users, :path=>"applicant", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :apply

  # Admin routes
  devise_for :admins, :path=>"admin", path_names: { sign_in: 'login', sign_out: 'logout' }
  scope '/admin' do
    resources :logic_questions
    resources :cohorts
    resources :admission_applications
    resources :profile_questions
    get 'dashboard/index', to: 'dashboard#index'
    get 'dashboard', to: 'dashboard#index'
    root 'dashboard#index', as: :admin_root_path
  end

  get '/launch', to: 'home#launch'
  get '/live', to: 'home#live'

  root 'home#index'

end
