class CreateLocodes < ActiveRecord::Migration[5.2]
  def change
    create_table :locodes do |t|

      t.timestamps
    end
  end
end
