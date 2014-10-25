class CreateEncuentros < ActiveRecord::Migration
  def change
    create_table :encuentros do |t|
      t.integer :gamera_id
      t.integer :gamerb_id
      t.integer :posicion_en_ronda
      t.integer :ronda_id
      t.string :flag_ganador
      t.string :descripcion
      t.integer :encuentro_anterior_a_id
      t.string :encuentro_anterior_b_id

      t.timestamps
    end
  end
end
