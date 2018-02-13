Rails.application.routes.draw do

  get 'Admin', to: 'dashboard#admin', as: :dashboard_admin 
  devise_for :admins, controllers: {
        sessions: 'admins/sessions'
  }
  get 'charts/index'

  get 'home/index'

  get 'tags/:tag',to: 'tags#index', as: :tag
  get 'dashboard',to: 'dashboard#index'
	devise_for :readonusers, controllers: {
        sessions: 'readonusers/sessions'
      }
  resources :articles do
    get 'page/:page', action: :index, on: :collection
    resources :comments
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end
    member do
      put "like" => "articles#upvote"
      put "unlike" => "articles#downvote"
    end
  end

  resources :home do
    get 'page/:page', action: :index, on: :collection
  end

  resources :dashboard do
    get 'page/:page', action: :index, on: :collection
  end

 
  get '/Category_Article/:id', to: 'category#index', as: :category_article
  get '/dashboard/comments', to: 'dashboard#comments', as: :dashboard_comments

  resources :categories
  resources :articles
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
