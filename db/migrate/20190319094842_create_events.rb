class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
