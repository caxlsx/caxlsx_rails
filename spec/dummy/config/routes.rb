Dummy::Application.routes.draw do
  resources :users
  match "/home(.:format)", :to => "home#index", :as => :home
  match "/another(.:format)", :to => "home#another", :as => :another
  match "/useheader(.:format)", :to => "home#useheader", :as => :useheader
  match "/withpartial(.:format)", :to => "home#withpartial", :as => :withpartial
  root to: "home#index"
end
