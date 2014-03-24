class CreateInscripcions < ActiveRecord::Migration
  def change
    create_table :inscripcions do |t|
      t.date :fecha_inscripcion
      t.time :hora_inscripcion
      t.string :estado_confirmacion
      t.integer :peso_participacion
      t.integer :gamer_id
      t.integer :torneo_id

      t.timestamps
    end
  end
end
