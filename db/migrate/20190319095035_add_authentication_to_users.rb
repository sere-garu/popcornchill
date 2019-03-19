class AddAuthenticationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authentication, :jsonb
  end
end
