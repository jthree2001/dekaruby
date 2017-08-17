class ChangeStatustoString < ActiveRecord::Migration[5.1]
  def change
    change_table :elements do |t|
      t.change :state, :string
    end
  end
end
