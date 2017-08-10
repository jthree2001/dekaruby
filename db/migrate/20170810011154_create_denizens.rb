class CreateDenizens < ActiveRecord::Migration[5.1]
  def change
    create_table :denizens do |t|
      t.string :full_name
      t.string :nickname
      t.string :location
      t.timestamps
    end
  end
end
