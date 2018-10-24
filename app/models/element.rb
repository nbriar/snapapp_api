class Element

  def self.available_elements
    # Every time we add a new element in the models we need to update this list
    %w(Title SubTitle Hyperlink Paragraph Spacer Divider )
  end

  def self.all
    Element.available_elements.map do |title|
      Element.find(title)
    end
  end

  def self.find(title)
    return false unless Element.available_elements.include? title

    el = title.constantize
    el.field_definitions
  end
end
