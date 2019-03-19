class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.string :preference
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
