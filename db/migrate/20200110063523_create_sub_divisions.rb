class CreateSubDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_divisions do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :region
      t.string :division
      t.timestamps
    end
  end
end
