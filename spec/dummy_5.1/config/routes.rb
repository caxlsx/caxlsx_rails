Rails.application.routes.draw do
  get "/users/:user_id/render_elsewhere(.:format)", :to => "likes#render_elsewhere"
  get "/users/:user_id/send_instructions", :to => "users#send_instructions"
  get "/users/noaction", :to => "users#noaction"
  get "/users/export/:id", :to => "users#export"
  resources :users do
    resources :likes
  end
  get "/home(.:format)", :to => "home#index", :as => :home
  get "/home/only_html", :to => "home#only_html", :as => :only_html
  get "/another(.:format)", :to => "home#another", :as => :another
  get "/useheader(.:format)", :to => "home#useheader", :as => :useheader
  get "/withpartial(.:format)", :to => "home#withpartial", :as => :withpartial
  get "/home/render_elsewhere(.:format)", :to => "home#render_elsewhere"
  get "/render_elsewhere(.:format)", :to => "home#render_elsewhere"
  root to: "home#index"
end
