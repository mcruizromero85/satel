class CreateTorneos < ActiveRecord::Migration
  def change
    create_table :torneos do |t|
      t.string :titulo
      t.string :paginaweb
      t.integer :vacantes
      t.date :cierre_inscripcion_fecha
      t.time :cierre_inscripcion_tiempo
      t.date :cierre_check_in_fecha
      t.time :cierre_check_in_tiempo
      t.date :inicio_torneo_fecha
      t.time :inicio_torneo_tiempo
      t.string :tipo_torneo
      t.string :tipo_generacion	
      t.integer :gamer_id
      t.integer :juego_id
      t.string :estado
      t.timestamps
    end
  end
end
