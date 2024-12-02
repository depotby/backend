Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    controller :authentications do
      get "authentications", action: :index
      post "authentications", action: :create
      put "authentications", action: :refresh
      delete "authentications", action: :destroy
    end
  end

  namespace :v1 do
    controller :user do
      get "user", action: :show
      post "user", action: :create
      put "user", action: :update
    end

    controller :authentications do
      get "authentications", action: :index
      post "authentications", action: :create
      put "authentications", action: :refresh
      delete "authentications", action: :destroy
    end

    controller :addresses do
      get "addresses", action: :index
      get "addresses/:id", action: :show
      post "addresses", action: :create
      put "addresses/:id", action: :update
      delete "addresses/:id", action: :destroy
    end
  end
end
