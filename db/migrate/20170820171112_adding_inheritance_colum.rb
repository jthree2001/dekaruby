class AddingInheritanceColum < ActiveRecord::Migration[5.1]
  def change
    change_table :elements do |t|
      t.string :element_type
    end
  end
end
