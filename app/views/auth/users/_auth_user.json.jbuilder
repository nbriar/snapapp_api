json.extract! auth_user, :id, :created_at, :updated_at
json.url auth_user_url(auth_user, format: :json)
