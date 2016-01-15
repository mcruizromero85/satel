# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160101181539) do

  create_table "authentications", force: true do |t|
    t.integer  "gamer_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "link_cuenta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icono"
  end

  create_table "chats", force: true do |t|
    t.string   "user_name"
    t.string   "received"
    t.string   "msg_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detalle_pago_inscripciones", force: true do |t|
    t.decimal "monto_inscripcion", default: 2.0, null: false
    t.integer "torneo_id",                       null: false
    t.decimal "monto_auspiciado"
  end

  create_table "encuentros", force: true do |t|
    t.integer  "gamerinscritoa_id"
    t.integer  "gamerinscritob_id"
    t.integer  "posicion_en_ronda"
    t.integer  "ronda_id"
    t.integer  "gamerinscrito_ganador_id"
    t.string   "descripcion"
    t.integer  "encuentro_anterior_a_id"
    t.string   "encuentro_anterior_b_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flag_listo_gamera",        default: false
    t.boolean  "flag_listo_gamerb",        default: false
    t.string   "estado",                   default: "Pendiente"
  end

  create_table "gamers", force: true do |t|
    t.string   "nick"
    t.string   "correo"
    t.string   "nombres"
    t.string   "apellidos"
    t.date     "fecha_ultimo_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "battletag"
  end

  create_table "hearthstone_forms", force: true do |t|
    t.integer  "inscripcion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "battletag"
  end

  create_table "hots_formularios", force: true do |t|
    t.integer  "inscripcion_id"
    t.string   "nombre_equipo"
    t.string   "capitan_nick"
    t.string   "titular_numero1"
    t.string   "titular_numero2"
    t.string   "titular_numero3"
    t.string   "titular_numero4"
    t.string   "suplente_numero1"
    t.string   "suplente_numero2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inscripciones", force: true do |t|
    t.integer  "torneo_id"
    t.integer  "gamer_id",                        null: false
    t.string   "estado"
    t.integer  "tipo_inscripcion",    default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nick"
    t.string   "id_transaccion_pago"
    t.string   "etiqueta_llave"
    t.string   "etiqueta_chat"
  end

  create_table "juegos", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "nombre_imagen"
    t.integer  "tipo_juego"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partidas", force: true do |t|
    t.integer  "encuentro_id"
    t.boolean  "flag_gano_gamerinscritoa"
    t.boolean  "flag_gano_gamerinscritob"
    t.string   "estado",                   default: "Pendiente"
    t.string   "field1"
    t.string   "field2"
    t.string   "field3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rondas", force: true do |t|
    t.integer  "numero"
    t.date     "inicio_fecha"
    t.time     "inicio_tiempo"
    t.string   "modo_ganar"
    t.integer  "torneo_id"
    t.integer  "ronda_siguiente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sc2_forms", force: true do |t|
    t.integer  "inscripcion_id"
    t.string   "race"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", force: true do |t|
    t.integer  "torneo_id"
    t.string   "html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo"
  end

  create_table "suscriptions", force: true do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torneos", force: true do |t|
    t.string   "titulo",                                      null: false
    t.string   "post_detalle_torneo"
    t.string   "urlstreeming"
    t.integer  "vacantes",                                    null: false
    t.datetime "cierre_inscripcion",                          null: false
    t.integer  "periodo_confirmacion_en_minutos",             null: false
    t.string   "tipo_torneo"
    t.string   "tipo_generacion"
    t.integer  "clasificacion"
    t.integer  "gamer_id"
    t.integer  "juego_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flag_inscripciones",              default: 1, null: false
    t.integer  "flag_pago_inscripciones",         default: 0, null: false
    t.string   "urllogo"
    t.string   "urllogoSponsors"
    t.decimal  "monto_auspiciado"
    t.string   "link_rules"
  end

  add_foreign_key "authentications", "gamers", name: "authentications_gamer_id_fk"

  add_foreign_key "detalle_pago_inscripciones", "torneos", name: "detalle_pago_inscripciones"

  add_foreign_key "encuentros", "rondas", name: "encuentros_ronda_id_fk"

  add_foreign_key "hearthstone_forms", "inscripciones", name: "hearthstone_forms_inscripcion_id_fk"

  add_foreign_key "hots_formularios", "inscripciones", name: "hots_formularios_inscripcion_id_fk"

  add_foreign_key "inscripciones", "gamers", name: "inscripciones_gamer_id_fk"
  add_foreign_key "inscripciones", "torneos", name: "inscripciones_torneo_id_fk"

  add_foreign_key "partidas", "encuentros", name: "partidas_encuentro_id_fk"

  add_foreign_key "rondas", "torneos", name: "rondas_torneo_id_fk"

  add_foreign_key "sc2_forms", "inscripciones", name: "sc2_forms_inscripcion_id_fk"

  add_foreign_key "torneos", "gamers", name: "torneos_gamer_id_fk"
  add_foreign_key "torneos", "juegos", name: "torneos_juego_id_fk"

end
