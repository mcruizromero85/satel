class AddBattleTagColumn < ActiveRecord::Migration
  def change
  	add_column :hearthstone_forms, :battletag, :string
  end
end
