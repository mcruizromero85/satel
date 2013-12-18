class CreatePruebas < ActiveRecord::Migration
  def change
    create_table :pruebas do |t|
      t.string :cadena
      t.integer :entero
      t.decimal :decimal
      t.date :fecha
      t.time :time

      t.timestamps
    end
  end
end
