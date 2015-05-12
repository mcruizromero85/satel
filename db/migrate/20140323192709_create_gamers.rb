class CreateGamers < ActiveRecord::Migration
  def change
    create_table :gamers do |t|
      t.string :nick
      t.string :correo
      t.string :nombres
      t.string :apellidos
      t.date :fecha_ultimo_login
      t.timestamps
    end
  end
end
