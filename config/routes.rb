Rails.application.routes.draw do
    
    resources :controllers
    resources :camps
    resources :camp_instructors
    resources :curriculums
    resources :instructors
    resources :locations
    resources :users
    resources :credit_cards
    resources :curriculums
    resources :families
    resources :students
    resources :registrations
    
    root to: 'home_page#index'
    
    resources :about_us
    resources :contact_us
    resources :privacy_page
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
