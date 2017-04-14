Rails.application.routes.draw do
  #our root is the vote index. As good a landing page as any!
  root 'votes#index'
  resources :votes, only: [:create, :index]
end
