Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "dev-admin.dtl-shop.by", "localhost:4000", "localhost:4173", "localhost:5173"

    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ]
  end
end
