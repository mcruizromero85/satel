Satel::Application.routes.draw do

  resources :hots_formularios

  resources :formulario_hots

  post '/comenzar' => 'torneos#comenzar'

  get '/chat' => 'torneos#chat'

  resources :datos_inscripcion_registrados

  resources :datos_inscripciones

  resources :inscripciones

  resources :authentications

  resources :asociados

  resources :juegos

  resources :encuentros

  resources :gamers

  resources :inscripcions

  get '/inscripciones/new/:id_torneo' => 'inscripciones#new'

  get '/torneos/preparar/:id' => 'torneos#preparar'

  get '/torneos/simular_llaves/:id' => 'torneos#simular_llaves'

  get '/inscripciones/confirmar/:id_torneo' => 'inscripciones#confirmar'

  get '/torneos/mis_torneos' => 'torneos#mis_torneos'
  get '/torneos/iniciar/:id_torneo' => 'torneos#iniciar_torneo'
  get '/inscripciones/revisar_datos_inscripcion/:id' => 'inscripciones#revisar_datos_inscripcion'
  get '/inscripciones/:id/eliminar' => 'inscripciones#destroy'
  get '/torneo_relampago/:id_torneo' => 'torneos#formulario_torneo_relampago'

  resources :rondas

  resources :torneos
  post '/agregar_gamers_temporales' => 'torneos#agregar_gamers_temporales'
  post '/comenzar' => 'torneos#comenzar'
  root 'torneos#index'
  get '/auth/:provider/callback' => 'authentications#create'
  post '/auth/:provider/callback' => 'authentications#create'
  get '/cerrar_sesion' => 'authentications#cerrar_sesion'
  
  
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
