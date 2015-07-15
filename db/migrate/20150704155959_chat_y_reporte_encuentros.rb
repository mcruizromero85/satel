class ChatYReporteEncuentros < ActiveRecord::Migration
  def change
  	add_column :inscripciones, :etiqueta_llave, :string
    add_column :inscripciones, :etiqueta_chat, :string
    add_column :encuentros, :flag_listo_gamera, :boolean,  :default => false
    add_column :encuentros, :flag_listo_gamerb, :boolean,  :default => false
    add_column :encuentros, :estado, :string,  :default => 'Pendiente'
    create_table :partidas do |t|
      t.integer :encuentro_id
      t.boolean :flag_gano_gamerinscritoa
      t.boolean :flag_gano_gamerinscritob
      t.string :estado, :default => 'Pendiente'
      t.string :field1
      t.string :field2
      t.string :field3
      t.timestamps
    end
    add_foreign_key :partidas, :encuentros
    create_table :chats do |t|
      t.string :user_name
      t.string :received
      t.string :msg_body
      t.timestamps
    end
  end
end
