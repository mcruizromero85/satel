class CreateJuegos < ActiveRecord::Migration
  def change
    create_table :juegos do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :asociado_id

      t.timestamps
    end
  end
end
