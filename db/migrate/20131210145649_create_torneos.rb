class CreateTorneos < ActiveRecord::Migration
  def change
    create_table :torneos do |t|
      t.string :nombre
      t.string :juego
      t.integer :vacantes
      t.date :cierre_inscripcion_fecha
      t.time :cierre_inscripcion_tiempo
      t.timestamps
    end
  end
end
