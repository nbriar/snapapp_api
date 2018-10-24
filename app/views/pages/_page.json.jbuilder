json.extract! page, :id, :title, :route, :customer_app_id, :components, :created_at, :updated_at
json.url customer_app_page_url(@active_app.id, page, format: :json)
