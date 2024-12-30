Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  unless Rails.env.production?
    mount Rswag::Ui::Engine => "/swagger"
    mount Rswag::Api::Engine => "/swagger"
  end

  scope defaults: { format: :json } do
    namespace :admin do
      scope :authentications, controller: :authentications do
        get "/", action: :index
        post "/", action: :create
        post "/refresh", action: :refresh
        delete "/", action: :destroy
      end

      scope :user, controller: :user do
        get "/", action: :show
      end

      scope :users, controller: :users do
        get "/", action: :index
        get "/:id", action: :show
      end

      scope :roles, controller: :roles do
        get "/", action: :index
        post "/", action: :create
        get "/:id", action: :show
        put "/:id", action: :update
        delete "/:id", action: :destroy
        post "/:id/abilities", action: :switch_ability
      end

      scope :categories, controller: :categories do
        get "/", action: :index
        post "/", action: :create
        get "/:id", action: :show
        put "/:id", action: :update
        delete "/:id", action: :destroy
      end

      scope "categories/:category_id/properties", controller: :category_properties do
        get "/", action: :index
        post "/", action: :create
        get "/:property_id", action: :show
        put "/:property_id", action: :update
        delete "/:property_id", action: :destroy
      end

      scope "categories/:category_id/properties/:property_id/options",
            controller: :category_property_options do
        post "/", action: :create
        put "/:option_id", action: :update
        delete "/:option_id", action: :destroy
      end

      scope :products, controller: :products do
        get "/", action: :index
        post "/", action: :create
        get "/:id", action: :show
        put "/:id", action: :update
        delete "/:id", action: :destroy
      end

      scope "products/:id/prices", controller: :product_prices do
        post "/", action: :create
      end
    end

    namespace :v1 do
      scope :user, controller: :user do
        get "/", action: :show
        post "/", action: :create
        put "/", action: :update
      end

      scope :authentications, controller: :authentications do
        get "/", action: :index
        post "/", action: :create
        post "/refresh", action: :refresh
        delete "/", action: :destroy
      end

      scope :addresses, controller: :addresses do
        get "/", action: :index
        get "/:id", action: :show
        post "/", action: :create
        put "/:id", action: :update
        delete "/:id", action: :destroy
      end
    end
  end
end
