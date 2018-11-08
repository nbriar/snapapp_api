class ComponentCreator

  def self.create(app_id:, name:, element: {}, collection_id: nil)
    element_type = element[:type]

    return false unless Template.available_elements.include? element_type

    element.delete(:type)

    element = element_type.constantize.create(element)
    Component.create(
      app_id: app_id,
      name: name,
      collection_id: collection_id,
      element_id: element.id,
      element_type: element_type
    )
  end

  def self.update(id:, name: nil, element: nil)
    component = Component.find id

    if element
      element.delete(:type)
      component.active_record_element.update(element)
    end

    if name
      component.update(name: name)
    end

    # We need to do this since we are updating a related element but
    # the relationship is not managed through Active Record
    component.reload
  end

  def self.delete(id:)
    component = Component.find id
    component.active_record_element.destroy
    component.destroy
  end

  def self.add_to_page(id:, page_id:)
    component = Component.find id
    page = Page.find page_id

    page.components << component
  end

  def self.add_to_collection(id:, collection_id:)
    component = Component.find id
    collection = Collection.find collection_id

    collection.components << component
  end

  def self.remove_from_page(id:, page_id:)
    component = Component.find id
    page = Page.find page_id

    page.components.delete(component)
  end

  def self.remove_from_collection(id:, collection_id:)
    component = Component.find id
    collection = Collection.find collection_id

    collection.components.delete component
  end
end
