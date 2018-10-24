# json.partial! "collections/collection", collection: @collection
json.extract! @collection, :id, :name, :app_id, :created_at, :updated_at
json.components @collection.components, partial: 'components/component', as: :component
json.url collection_url(@collection, format: :json)
