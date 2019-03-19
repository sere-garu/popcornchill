class FixNetflixPayload < ActiveRecord::Migration[5.2]
  def change
    rename_column :movies, :netflix_payload, :trakt_payload
  end
end
