Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboards#show", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "homes#show"
  end

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
end
