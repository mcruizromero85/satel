class AddSc2Form < ActiveRecord::Migration
  def change
  	create_table :sc2_forms do |t|
  	  t.integer :inscripcion_id
      t.string :race
      t.timestamps
    end
    add_foreign_key :sc2_forms, :inscripciones
    add_column :gamers, :battletag, :string
  end
end
