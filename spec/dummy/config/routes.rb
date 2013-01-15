Dummy::Application.routes.draw do
  resources :users do
    resources :likes
  end
  get "/users/:user_id/render_elsewhere(.:format)", :to => "likes#render_elsewhere"
  get "/home(.:format)", :to => "home#index", :as => :home
  get "/another(.:format)", :to => "home#another", :as => :another
  get "/useheader(.:format)", :to => "home#useheader", :as => :useheader
  get "/withpartial(.:format)", :to => "home#withpartial", :as => :withpartial
  get "/home/render_elsewhere(.:format)", :to => "home#render_elsewhere"
  get "/render_elsewhere(.:format)", :to => "home#render_elsewhere"
  root to: "home#index"
end
