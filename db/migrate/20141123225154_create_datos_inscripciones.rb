class CreateDatosInscripciones < ActiveRecord::Migration
  def change
    create_table :datos_inscripciones do |t|
      t.integer :inscripcion_id
      t.string :nombre_dato
      t.string :valor_dato

      t.timestamps
    end
  end
end
