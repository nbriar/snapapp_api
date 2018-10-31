class GraphqlController < PrivateController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      user: active_user,
      account: active_account,
      customer_app: active_app
    }

    result = SnapAppApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def active_app
    @customer_app ||= CustomerApp.find(request.headers['X-APP-ID'])
  rescue ActiveRecord::RecordNotFound
    @customer_app = nil
  end
end
