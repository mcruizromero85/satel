class CreatePrueba2s < ActiveRecord::Migration
  def change
    create_table :prueba2s do |t|
      t.string :estado

      t.timestamps
    end
  end
end
