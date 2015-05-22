class CreateTorneos < ActiveRecord::Migration
  def change
    create_table :torneos do |t|
            t.string   "titulo", null: false
            t.string   "post_detalle_torneo"
            t.string   "urlstreeming"
            t.integer  "vacantes", null: false
            t.datetime "cierre_inscripcion", null: false
            t.integer  "periodo_confirmacion_en_minutos", null: false
            t.string   "tipo_torneo"# Individual / Moba
            t.string   "tipo_generacion" #Simple / Doble / Grupos Round Robin / Grupos Round Robin doble llave
            t.integer  "clasificacion" #0 -> Normal ó 1 -> Destacado
            t.integer  "flag_inscripciones", null: false, default: 1 #0 -> No disponible, 1 -> Disponible
            t.integer  "gamer_id"
            t.integer  "juego_id"
            t.string   "estado"
            t.datetime "created_at"
            t.datetime "updated_at"
    end
  end
end
