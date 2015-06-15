class CreateHotsFormularios < ActiveRecord::Migration
  def change
    create_table :hots_formularios do |t|
      t.integer :inscripcion_id
      t.string :nombre_equipo	
      t.string :capitan_nick
      t.string :titular_numero1
      t.string :titular_numero2
      t.string :titular_numero3
      t.string :titular_numero4
      t.string :suplente_numero1
      t.string :suplente_numero2
      t.timestamps
    end
    add_foreign_key :hots_formularios, :inscripciones
  end
end
