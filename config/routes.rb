Rails.application.routes.draw do


  get 'send_mail' => 'mail_masters#send_mail', as: :send_mail
  get 'drafts' => 'mail_masters#drafts', as: :drafts
  get 'sent_mails' => 'mail_masters#sent_mails', as: :sent_mails
  get 'push_mail/:id' => "mail_masters#push_mail", as: :push_mail
  get 'edit_draft/:id' => 'mail_masters#edit_draft', as: :edit_draft
  post 'send_create' => 'mail_masters#send_create', as: :send_create
  post 'update_draft' => 'mail_masters#update_draft', as: :update_draft

  post 'getbody' => "templates#getbody", as: :getbody

  get 'quick_mail'   => "quickmail#quick_mail",   as: :quick_mail
  post 'quick_create' => "quickmail#quick_create", as: :quick_create


  get 'mail_group_lists/:group_id' => "mail_group_mappings#mail_group_lists", as: :mail_group_lists
  
  get 'email_upload' => "emails#email_upload", as: :email_upload
  get 'sample_csv' => "emails#sample_csv", as: :sample_csv
  post 'emails_import' => "emails#emails_import", as: :emails_import


  get 'test_sender_email/:id' => "sender_emails#test_sender_email", as: :test_sender_email

  get 'client_info_disable/:id' => "client_infos#client_info_disable", as: :client_info_disable
  get 'client_info_enable/:id' => "client_infos#client_info_enable", as: :client_info_enable

  get 'client_user_list/:client_id' => 'users#client_user_list', as: :client_user_list
  get 'new_client_user/:client_id' => "users#new_client_user", as: :new_client_user
  post 'create_client_user' => 'users#create_client_user', as: :create_client_user
  get 'edit_client_user/:id' => "users#edit_client_user", as: :edit_client_user
  post 'update_client_user' => "users#update_client_user", as: :update_client_user

  get 'client_users' => "users#client_users", as: :client_users
  get 'new_user_client' => "users#new_user_client", as: :new_user_client
  post 'create_user_client' => "users#create_user_client", as: :create_user_client
  get 'edit_user_client/:id' => "users#edit_user_client", as: :edit_user_client
  post 'update_user_client' => "users#update_user_client", as: :update_user_client
  

  
  get 'admin_users' => 'users#admin_users', as: :admin_users
  get 'new_admin_user' => 'users#new_admin_user', as: :new_admin_user
  get 'admin_users_edit/:id' => 'users#admin_users_edit', as: :admin_users_edit
  post 'admin_create_user' => 'users#admin_create_user', as: :admin_create_user
  post 'admin_edit_user' => 'users#admin_edit_user', as: :admin_edit_user

  resources :mail_attachments
  # resources :mail_masters
  resources :transactions  
  resources :templates
  resources :emails_mail_groups
  resources :emails_mail_groups
  resources :mail_groups
  resources :emails
  resources :sender_emails
  resources :client_infos
  resources :payment_types
  resources :permissions
  resources :permissions_roles
  resources :roles
  devise_for :users

  root 'home#dashboard'

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
