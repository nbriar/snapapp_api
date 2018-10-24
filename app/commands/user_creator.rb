class UserCreator

  def self.find_or_create(external_id:)
    user = Auth::User.find_or_initialize_by(external_id: external_id)

    if user.id.present? || user.save
      user
    else
      false
    end
  end

  def self.delete(id:)
    user = Auth::User.find id
    user.destroy
  end
end
