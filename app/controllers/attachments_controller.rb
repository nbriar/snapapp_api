class AttachmentsController < RequiresAppController
  def create
    return head 204 if attach_component_to_collection
    return head 204 if attach_component_to_page
    return head 204 if attach_collection_to_page

    head 400
  end

  def destroy
    return head 204 if remove_component_from_collection
    return head 204 if remove_component_from_page
    return head 204 if remove_collection_from_page

    head 400
  end

  private

  def attach_component_to_collection
    return false unless params[:component_id] && params[:collection_id]

    ComponentCreator.add_to_collection(id: params[:component_id], collection_id: params[:collection_id])
  end

  def attach_component_to_page
    return false unless params[:component_id] && params[:page_id]

    ComponentCreator.add_to_page(id: params[:component_id], page_id: params[:page_id])
  end

  def attach_collection_to_page
    return false unless params[:collection_id] && params[:page_id]

    CollectionCreator.add_to_page(id: params[:collection_id], page_id: params[:page_id])
  end

  def remove_component_from_collection
    return false unless params[:component_id] && params[:collection_id]

    ComponentCreator.remove_from_collection(id: params[:component_id], collection_id: params[:collection_id])
  end

  def remove_component_from_page
    return false unless params[:component_id] && params[:page_id]

    ComponentCreator.remove_from_page(id: params[:component_id], page_id: params[:page_id])
  end

  def remove_collection_from_page
    return false unless params[:collection_id] && params[:page_id]

    CollectionCreator.remove_from_page(id: params[:collection_id], page_id: params[:page_id])
  end

  def collection_params
    params.require(:collection).permit!
  end
end
