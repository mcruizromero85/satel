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

ActiveRecord::Schema.define(version: 20140817033501) do

  create_table "asociados", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "juego_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.integer  "gamer_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encuentros", force: true do |t|
    t.string   "estado"
    t.integer  "posicion_en_ronda"
    t.integer  "id_inscripcion_gamer_a"
    t.integer  "id_inscripcion_gamer_b"
    t.integer  "id_inscripcion_gamer_ganador"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamers", force: true do |t|
    t.string   "nick"
    t.string   "correo"
    t.string   "nombres"
    t.string   "apellidos"
    t.date     "fecha_ultimo_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inscripciones", force: true do |t|
    t.integer  "torneo_id"
    t.integer  "gamer_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "juegos", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "asociado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ordens", force: true do |t|
    t.string   "dni"
    t.string   "password"
    t.string   "sku"
    t.string   "medio_de_pago"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prueba2s", force: true do |t|
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pruebas", force: true do |t|
    t.string   "titulo"
    t.string   "descripcion"
    t.string   "formato"
    t.string   "modalidad"
    t.integer  "juego_id"
    t.string   "modalidad_reporte_victoria"
    t.integer  "vacantes"
    t.date     "cierre_inscripcion_fecha"
    t.time     "cierre_inscripcion_tiempo"
    t.date     "cierre_check_in_fecha"
    t.time     "cierre_check_in_tiempo"
    t.date     "inicio_torneo_fecha"
    t.string   "inicio_torneo_tiempo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rondas", force: true do |t|
    t.integer  "numero"
    t.date     "inicio_fecha"
    t.time     "inicio_tiempo"
    t.integer  "modo_ganar"
    t.integer  "torneo_id"
    t.integer  "ronda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torneos", force: true do |t|
    t.string   "titulo"
    t.string   "paginaweb"
    t.integer  "vacantes"
    t.date     "cierre_inscripcion_fecha"
    t.time     "cierre_inscripcion_tiempo"
    t.integer  "periodo_confirmacion_en_minutos"
    t.string   "tipo_torneo"
    t.string   "tipo_generacion"
    t.integer  "gamer_id"
    t.integer  "juego_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
