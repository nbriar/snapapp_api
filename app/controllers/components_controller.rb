class ComponentsController < RequiresAppController
  before_action :set_component, only: [:show, :update, :destroy, :attach]

  # GET /components
  # GET /components.json
  def index
    @components = Component.for_app(@active_app)
  end

  # GET /components/1
  # GET /components/1.json
  def show
  end

  # POST /components
  # POST /components.json
  def create
    @component = ComponentCreator.create(
      app_id: app_id,
      name: component_params[:name],
      element: component_params[:element],
      collection_id: component_params[:collection_id]
    )

    if @component.errors.empty?
      render :show, status: :created, location: @component
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    @component = ComponentCreator.update(
      id: params[:id],
      name: component_params[:name],
      element: component_params[:element]
    )

    if @component.errors.empty?
      render :show, status: :ok, location: @component
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    ComponentCreator.delete(id: @component.id)
  end

  def attach
    if params[:attach_to] == "Page"
      page = Page.find params[:page_id]
      page.components << @component
    end

    if params[:attach_to] == "Collection"
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    def component_params
      params.require(:component).permit!
    end
end
