Rails.application.routes.draw do


  # Public routes
  devise_for :users, :path=>"applicant", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :apply

  # Admin routes
  devise_for :admins, :path=>"admin", path_names: { sign_in: 'login', sign_out: 'logout' }
  scope '/admin' do
    resources :logic_questions
    resources :profile_questions    
    resources :cohorts
  end

  get '/launch', to: 'home#launch'
  get '/live', to: 'home#live'

  root 'home#index'

end
