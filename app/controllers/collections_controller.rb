class CollectionsController < RequiresAppController
  before_action :set_collection, only: [:show, :update, :destroy]

  def index
    @collections = Collection.for_app(@active_app)
  end

  def show; end

  def create
    @collection = CollectionCreator.create(
      app_id: app_id,
      name: collection_params[:name],
      components: collection_params[:components],
    )

    if @collection.errors.empty?
      render :show, status: :created, location: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def update
    CollectionCreator.update(id: @collection.id, name: collection_params[:name])
  end

  def destroy
    CollectionCreator.delete(id: @collection.id)
  end

  private
  def set_collection
    @collection = Collection.find(params[:id])
  end

  # Object structure for posting to this endpoint
  #
  # {app_id: "sometest",
  # name: "some collection",
  # components: [
  #   {
  #     name: "some name1",
  #     element: {type: "Title", size: 1, text: "Auto Created Component"}
  #   },
  #   {
  #     name: "some name2",
  #     element: {type: "Title", size: 2, text: "Auto Created Component2"}
  #   },
  #   {
  #     name: "some name3",
  #     element: {type: "Title", size: 3, text: "Auto Created Component3"}
  #   },
  #   ...
  # ]}
  def collection_params
    params.require(:collection).permit!
  end
end
