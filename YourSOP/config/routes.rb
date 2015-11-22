Rails.application.routes.draw do

  resources :topics

  resources :organisations do
    collection do
      get :invite
      get :users
      delete :remove_user
      get :edit_user
      put :update_user
      get :services
      put :update_service
      get :import
      put :update_sops
      get :browse
    end
    put :save_current_organisation#, :on => :collection

    get :autocomplete_user_email, :on => :collection
  end

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users

  resources :documents do
    collection do
      put :save_role_response, as: :save_role_response
    end
  end

  resources :risks

  resources :audits do
    collection do
      put :save_audit_response, as: :save_audit_response
    end
  end

  resources :topics

  get 'documents/index'
  get 'documents/dashboard'
  match 'documents', to: 'documents#handle_status', via: :put, as: :handle_status
  match 'documents/:id/revise' => 'documents#revise', via: :get, as: 'revise'


  match 'organisations/save_current_organisation', to: 'organisations#save_current_organisation', via: :post
  match "organisations/accept_organisation_invitation", to: 'organisations#accept_organisation_invitation', via: :post


  match 'organisations/invite', to: 'organisations#inviteSubmission', via: :post
  match 'organisations/join/:id' => 'organisations#join', via: :get

  #match "your_documents" => 'documents#your_documents', via: :post, as: 'your_documents'
  #match "your_actions" => 'documents#your_actions', via: :post, as: 'your_actions'
  #match "all_documents" => 'documents#all_documents', via: :post, as: 'all_documents'
  match "revert_to_draft" => "documents#revert_to_draft", via: :post, as: 'revert_to_draft'

  root to: "home#index"

  match 'documents/:id/revision/:major-:minor' => 'documents#revision', via: :get, as: 'revision'


  match 'documents/:id/compare/:revision1/:revision2' => 'documents#compare', via: :get, as: 'compare'

  mount Commontator::Engine => '/commontator'

  get 'risks/index'
  match 'risks', to: 'risks#handle_listRisks', via: :put, as: "handle_listRisks"
  match 'list_risks' => 'risks#list_risks', via: :post, as: 'list_risks'


  match 'audits', to: 'audits#handle_audit_status', via: :put, as: :handle_audit_status
  match 'list_audits' => 'audits#list_audits', via: :post, as: 'list_audits'
  match 'audits/:id/result' => 'audits#result', via: :get, as: 'result'
  match "start_audit" => "audits#start_audit", via: :post, as: 'start_audit'

  get 'home/index'

  #resources :notifications, only: [:index, :show, :destroy]

  resources :home, only: [:index] do
    member do
      post :mark_as_read
    end
    collection do
      put :save_audit_action, as: :save_audit_action
    end
  end

  get 'dashboard/index'
  match "audit_this_year" => "dashboard#audit_this_year", via: :get, as: 'audit_this_year'
  match "topic_risk_trend" => "dashboard#topic_risk_trend", via: :get, as: 'topic_risk_trend'
  match "document_status" => "dashboard#document_status", via: :get, as: 'document_status'
  match "audit_result" => "dashboard#audit_result", via: :get, as: 'audit_result'
  match "compliance_rate" => "dashboard#compliance_rate", via: :get, as: 'compliance_rate'

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
