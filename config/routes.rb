Additiveanalytics::Application.routes.draw do

  root to: 'static_pages#home'

  devise_for :users

  resources :unity_servers

  resources :states

  resources :providers

  resources :medicare_costs

  # Transactional emails with Mandrill
  resources :inbox, controller: 'inbox', only: [:show, :create]

  # Static pages
  # For everybody to see
  get '/' => 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/privacy_policy' => 'static_pages#privacy_policy'
  get '/terms' => 'static_pages#terms'

  # /solutions folder
  # For everybody to see
  get '/solutions' => 'solutions#list'
  get '/solutions/custom_analytics' => 'solutions#custom_analytics'
  get '/solutions/hospital_compare' => 'solutions#hospital_compare'
  get '/solutions/maternity' => 'solutions#maternity'
  get '/solutions/readmissions' => 'solutions#readmissions'
  get '/solutions/flu_tracker' => 'solutions#flu_tracker'
  get '/solutions/flu_tracker_data' => 'solutions#flu_tracker_data'
  get '/solutions/treatment_tracker' => 'solutions#treatment_tracker'
  get '/solutions/reduce_readmissions' => 'solutions#reduce_readmissions'
  get '/solutions/compare_prices' => 'solutions#compare_prices'
  get '/solutions/compare_prices_data' => 'solutions#compare_prices_data'
  get '/solutions/nationwide_price_compare' => 'solutions#nationwide_price_compare'
  get '/solutions/nationwide_price_compare_data' => 'solutions#nationwide_price_compare_data'

  # /immunization_tracker
  # Behind a login -- must be a verified provider w/ credentials
  get '/immunization_tracker' => 'immunization_tracker#index'

  resources :immunization_tasks do
    get :reset_filterrific, on: :collection
  end

  # Blog (goes to wordpress blog on other server)
  get '/blog' => redirect('/blog/')

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
