Rails.application.routes.draw do
  root 'welcome#index'
  resources :employees do
    get "score_new"
    post "score_new", to: "employees#score_create" 
  end
  delete "employees/score_destroy/:id", to: "employees#score_destroy"

  devise_for :users, controllers: { registrations: "users/registrations"}
  devise_scope :user do
    get 'new_basic', to: "users/registrations#new_basic"
    post 'new_basic', to: "users/registrations#create_new_basic"
    get 'new_pro', to: "users/registrations#new_pro"
    post 'new_pro', to: "users/registrations#create_new_pro"
    post 'downgrade', to: "users/registrations#downgrade"
    post 'upgrade', to: "users/registrations#upgrade"
    post 'avrg', to: "users/registrations#update_average_border"
  end
  devise_for :reviewers, controllers: { registrations: "reviewers/registrations", sessions: "reviewers/sessions"}

  delete 'reviewer_delete/:id', to: "application#destroy_reviewer"

  #resources :reviewers

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
