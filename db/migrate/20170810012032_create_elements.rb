class CreateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :elements do |t|
      t.string :entity_id
      t.string :friendly_name
      t.bool :state

      t.timestamps
    end
  end
end
