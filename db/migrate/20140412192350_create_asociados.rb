class CreateAsociados < ActiveRecord::Migration
  def change
    create_table :asociados do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :juego_id

      t.timestamps
    end
  end
end
