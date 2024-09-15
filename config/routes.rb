Rails.application.routes.draw do
  unless Rails.env.development?
    get "/service-worker.js", to: "pwa#service_worker", as: :pwa_service_worker
    get "/manifest.json", to: "pwa#manifest", as: :pwa_manifest
  end

  passwordless_for :guests
  resources :guests

  get "RSVP", to: "parties#new" # in case of all caps
  get "rsvp", to: "parties#new", as: :new_party
  get "rsvp/step-2(/:id)", to: "parties#onboarding", as: :onboarding
  resource :party, except: [:new, :index, :destroy]
  resources :guilds, only: [:index, :show]

  get "registry", to: "infos#registry", as: :registry

  get "realm", to: "infos#map", as: :map
  get "map", to: "infos#map" # just in case people try it
  resources :locations, only: [:index]

  namespace :dungeon_master, path: "dm" do
    resources :parties
    resources :guilds
    resources :quests
    resources :guests
    resources :locations
    resources :mailings, only: [:index, :new, :show, :create]
    root "guests#index"
  end

  root "infos#home"
end
