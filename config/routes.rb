Rails.application.routes.draw do
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'welcome/index'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  get 'admin', to: 'admin#index', as: :admin_root

  namespace :admin do
    resources :users
    post 'users/:id/approve' => 'users#approve', :as => :user_approve
    #get 'sign_in'     => 'sessions#new'
    #post 'sign_in'    => 'sessions#create'
    #delete 'sign_out' => 'sessions#destroy'
  end

  namespace :api, :defaults => { :format => 'json' } do

    namespace :users do
      # Sign Up, Sign In, Sign Out, Recovery password operations
      post   'sign_up'  => 'registrations#create'
      post   'sign_in'  => 'sessions#create',      :as => :session
      delete 'sign_out' => 'sessions#destroy'
      post   'password' => 'passwords#create'

      # Users operations
      get    'search'   => 'search_engine#basic_search'

      # Single user operations
      get    ':id'                    => 'profile#show'
      post   ':id/edit'               => 'profile#update'
      post   'upload_profile_picture' => 'profile#upload_picture'

      #Wall comments operations
      get ':id/wall/comments' => 'wall/comments#show'
      post ':id/wall/comments' => 'wall/comments#create_wall_comment'
      post ':id/wall/notifications' => 'wall/comments#create_wall_notification'
    end

    namespace :jobs do
      post    'create_job' => 'job#create'
      post    ':id/edit'  => 'job#edit'
      post    ':id/destroy' => 'job#destroy'
    end

    namespace :educations do
      post    'create_education' => 'educations#create'
      post    ':id/edit'  => 'educations#edit'
      post    ':id/destroy' => 'educations#destroy'
    end

    namespace :academic_info do
      post    'edit_career' => 'academic_info#edit'
    end

    namespace :friends do
      get  ''                            => 'friendships#index'
      get  'pending_friendship_requests' => 'friendship_requests#index'
      post 'send_friendship_request'     => 'friendship_requests#create'
      post 'respond_friendship_request'  => 'friendship_requests#reply'
    end

    namespace :groups do
      get  ''            => 'groups#index'
      post ''            => 'groups#create'
      get  'search'      => 'search_engine#basic_search'
      get  ':id/members' => 'members#index'
      post ':id/join'    => 'members#join'

      # Discussions routes
      get  ':id/discussions' => 'discussions/discussions#index'
      post ':id/discussions' => 'discussions/discussions#create'
      get  ':id/discussions/:discussion_id' => 'discussions/discussions#show'

      # Discussion and comments routes
      post ':id/discussions/:discussion_id/comments' => 'discussions/comments#create_group_comment'

      # uploaded_data aka FILES ( but thats a reserved keyword)
      get  ':id/uploaded_data' => 'uploaded_data/uploaded_data#index'
      post ':id/uploaded_data' => 'uploaded_data/uploaded_data#create'
      #get  ':id/uploaded_data/:uploaded_data_id' => 'uploaded_data/uploaded_data#show'

    end

  end

end
