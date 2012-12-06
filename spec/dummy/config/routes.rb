Dummy::Application.routes.draw do
  resources :users do
    resources :likes
  end
  match "/users/:user_id/render_elsewhere(.:format)", :to => "likes#render_elsewhere"
  match "/home(.:format)", :to => "home#index", :as => :home
  match "/another(.:format)", :to => "home#another", :as => :another
  match "/useheader(.:format)", :to => "home#useheader", :as => :useheader
  match "/withpartial(.:format)", :to => "home#withpartial", :as => :withpartial
  match "/home/render_elsewhere(.:format)", :to => "home#render_elsewhere"
  match "/render_elsewhere(.:format)", :to => "home#render_elsewhere"
  root to: "home#index"
end
