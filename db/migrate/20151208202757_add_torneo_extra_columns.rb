class AddTorneoExtraColumns < ActiveRecord::Migration
  def change
  	add_column :torneos, :link_rules, :string
  end
end
