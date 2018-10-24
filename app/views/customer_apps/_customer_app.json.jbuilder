json.extract! customer_app, :id, :name, :slug, :created_at, :updated_at
json.url customer_app_url(customer_app, format: :json)
