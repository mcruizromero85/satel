class CreateDatosInscripcionRegistrados < ActiveRecord::Migration
  def change
    create_table :datos_inscripcion_registrados do |t|
      t.integer :datos_inscripcion_id
      t.string :valor
      t.integer :inscripcion_id

      t.timestamps
    end
  end
end
