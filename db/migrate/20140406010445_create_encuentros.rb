class CreateEncuentros < ActiveRecord::Migration
  def change
    create_table :encuentros do |t|
      t.string :estado
      t.integer :posicion_en_ronda
      t.integer :id_inscripcion_gamer_a
      t.integer :id_inscripcion_gamer_b
      t.integer :id_inscripcion_gamer_ganador

      t.timestamps
    end
  end
end
