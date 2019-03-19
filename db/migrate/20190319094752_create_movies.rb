class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.jsonb :netflix_payload

      t.timestamps
    end
  end
end
