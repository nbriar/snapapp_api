class TemplatesController < PrivateController
  before_action :set_template, only: [:show, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.includes(:template_elements).all
  end

  # GET /templates/1
  # GET /templates/1.json
  def show; end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)

    if @template.save
      render :show, status: :created, location: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    update_elements if elements_params.present?
    @template.update(name: template_params[:name]) if template_params[:name].present?

    if @template.errors.empty?
      render :show, status: :ok, location: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      head 404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:name, elements: [:type, :ordinal])
    end

    def elements_params
      template_params[:elements]
    end

    def update_elements
      @template.template_elements.destroy_all
      elements_params.each do |el|
        @template.add_element(type: el[:type], ordinal: el[:ordinal] || 0)
      end
    end
end
