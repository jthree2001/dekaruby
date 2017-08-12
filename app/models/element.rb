class Element < ApplicationRecord
  belongs_to :denizen

  def owner_name
    unless self.denizen_id.blank?
      return Denizen.find(self.denizen_id).full_name
    else
      return nil
    end
  end
end
