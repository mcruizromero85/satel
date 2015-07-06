class ChatYReporteEncuentros < ActiveRecord::Migration
  def change
  	add_column :inscripciones, :etiqueta_llave, :string
    add_column :inscripciones, :etiqueta_chat, :string
  end
end
