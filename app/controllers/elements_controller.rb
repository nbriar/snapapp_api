class ElementsController < PrivateController
  # GET /elements
  # GET /elements.json
  def index
    @elements = Element.all
    render json: { elements: @elements }
  end

  # GET /elements/1
  # GET /elements/1.json
  def show
    @element = Element.find(params[:id])
    render json: @element
  end
end
