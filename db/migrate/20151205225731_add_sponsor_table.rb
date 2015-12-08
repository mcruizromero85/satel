class AddSponsorTable < ActiveRecord::Migration
  def change
  	create_table :sponsors do |t|  	  
      t.integer :torneo_id
      t.string :html
      t.timestamps
    end
    add_foreign_key :sponsors, :torneos
  end
end
