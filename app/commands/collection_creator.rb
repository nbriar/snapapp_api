class CollectionCreator
  def self.create(app_id:, components:, name: "")
    collection = Collection.create(name: name, app_id: app_id)

    components.each do |component|
      c = component.to_h.symbolize_keys

      new_component = ComponentCreator.create(app_id: app_id, name: "#{name}:#{c[:name]}", element: c[:element])
      collection.components << new_component
    end

    collection
  end

  def self.update(id:, name:)
    collection = Collection.find id
    collection.update(name: name)
  end

  def self.delete(id:)
    collection = Collection.find id

    collection.components.each do |component|
      component.active_record_element.destroy
      component.destroy
    end

    collection.destroy
  end

  def self.add_to_page(id:, page_id:)
    collection = Collection.find id
    page = Page.find page_id

    page.collections << collection
  end

  def self.remove_from_page(id:, page_id:)
    collection = Collection.find id
    page = Page.find page_id

    page.collections.delete collection
  end
end
