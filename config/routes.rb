Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.htm
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :agents
      resources :labs
      resources :patient_appointments
      resources :patient_samples
      resources :passwords
      resources :users, only: [ :update ] do
        member do
          post "send_otp"
          patch "reset_password"
        end
      end
    end
  end
end
