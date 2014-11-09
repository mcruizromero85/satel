class CreateTorneos < ActiveRecord::Migration
  def change
    create_table :torneos do |t|
      t.string :titulo
      t.string :paginaweb
      t.integer :vacantes
      t.timestamp :cierre_inscripcion_fecha
      t.timestamp :cierre_inscripcion_tiempo
      t.integer :periodo_confirmacion_en_minutos
      t.string :tipo_torneo
      t.string :tipo_generacion	
      t.integer :gamer_id
      t.integer :juego_id
      t.string :estado
      t.timestamps
    end
  end
end
