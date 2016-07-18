class AddGamerColumns < ActiveRecord::Migration
  def change
  	add_column :gamers, :facebook_token, :string
  	add_column :gamers, :facebook_id, :string
  end
end
