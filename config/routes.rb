Rails.application.routes.draw do
  
  root 'home#index'
  # get 'home/zipcode'
  
  post 'zipcode' => 'home#zipcode'
end
