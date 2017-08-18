class GivingDenizensAccess < ActiveRecord::Migration[5.1]
  def change
    change_table :denizens do |t|
      t.string :access
    end
  end
end
