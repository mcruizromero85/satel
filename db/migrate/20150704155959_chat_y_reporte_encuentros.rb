class ChatYReporteEncuentros < ActiveRecord::Migration
  def change
  	add_column :inscripciones, :etiqueta_llave, :string
    add_column :inscripciones, :etiqueta_chat, :string
    add_column :encuentros, :flag_listo_gamera, :boolean,  :default => false
    add_column :encuentros, :flag_listo_gamerb, :boolean,  :default => false
  end
end
