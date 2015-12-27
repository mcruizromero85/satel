class AddHearthStoneForm < ActiveRecord::Migration
  def change
  	create_table :hearthstone_forms do |t|
  	  t.integer :inscripcion_id
      t.timestamps
    end
    add_foreign_key :hearthstone_forms, :inscripciones    
  end
end
