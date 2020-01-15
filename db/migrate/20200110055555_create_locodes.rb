class CreateLocodes < ActiveRecord::Migration[5.2]
  def change
    create_table :locodes do |t|
      t.string :code
      t.string :city
      t.string :name
      t.string :name_diacritics
      t.string :function
      t.string :iata
      t.string :status
      t.string :date
      t.string :remarks
      t.string :coordinates
      t.float :latitude
      t.float :longitude 
      t.references :sub_division
      t.timestamps
    end
  end
end
