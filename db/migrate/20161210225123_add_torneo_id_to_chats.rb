class AddTorneoIdToChats < ActiveRecord::Migration
  def change
  	add_column :chats, :torneo_id, :string
  	add_column :chats, :preferences, :string
  end
end
