class CreateRondas < ActiveRecord::Migration
  def change
    create_table :rondas do |t|
      t.integer :numero
      t.date :inicio_fecha
      t.time :inicio_tiempo
      t.string :modo_ganar
      t.integer :torneo_id

      t.timestamps
    end
  end
end
