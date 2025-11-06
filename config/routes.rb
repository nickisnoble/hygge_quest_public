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
  resource :party, except: [:new, :destroy]

  get "map", to: "infos#map", as: :map
  resources :locations, only: [:index]

  namespace :admin do
    resources :parties
    resources :groups
    resources :guests
    resources :locations
    resources :mailings, only: [:index, :new, :show, :create]
    resources :pages
    root "guests#index"
  end

  # Dynamic pages (e.g., /registry, /travel-info, etc.)
  get "/:slug", to: "pages#show", as: :page, constraints: { slug: /[a-z0-9-]+/ }

  root "infos#home"
end
