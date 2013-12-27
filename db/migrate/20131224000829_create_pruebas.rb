class CreatePruebas < ActiveRecord::Migration
  def change
    create_table :pruebas do |t|
      t.string :titulo
      t.string :descripcion
      t.string :formato
      t.string :modalidad
      t.integer :juego_id
      t.string :modalidad_reporte_victoria
      t.integer :vacantes
      t.date :cierre_inscripcion_fecha
      t.time :cierre_inscripcion_tiempo
      t.date :cierre_check_in_fecha
      t.time :cierre_check_in_tiempo
      t.date :inicio_torneo_fecha
      t.string :inicio_torneo_tiempo

      t.timestamps
    end
  end
end
