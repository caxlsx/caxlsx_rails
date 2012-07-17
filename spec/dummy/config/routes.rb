Dummy::Application.routes.draw do
  resources :users
  match "/home(.:format)", :to => "home#index", :as => :home
  match "/another(.:format)", :to => "home#another", :as => :another
  root to: "home#index"
end
