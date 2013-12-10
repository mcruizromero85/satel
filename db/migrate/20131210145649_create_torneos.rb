class CreateTorneos < ActiveRecord::Migration
  def change
    create_table :torneos do |t|
      t.string :nombre
      t.string :juego
      t.integer :vacantes
      t.date :cierre_inscripcion

      t.timestamps
    end
  end
end
