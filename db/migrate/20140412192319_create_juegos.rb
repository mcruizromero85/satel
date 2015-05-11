class CreateJuegos < ActiveRecord::Migration
  def change
    create_table :juegos do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :tipo_juego # 0 -> normal, 1 -> Corresponde a torneo destacado
      t.timestamps
    end
  end
end
