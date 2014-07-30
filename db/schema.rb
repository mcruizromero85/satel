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

ActiveRecord::Schema.define(version: 20140412192350) do

  create_table "asociados", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "juego_id"
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

  create_table "inscripcions", force: true do |t|
    t.date     "fecha_inscripcion"
    t.time     "hora_inscripcion"
    t.string   "estado_confirmacion"
    t.integer  "peso_participacion"
    t.integer  "posicion_inicial"
    t.integer  "gamer_id"
    t.integer  "torneo_id"
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

  create_table "rondas", force: true do |t|
    t.integer  "numero"
    t.date     "inicio_fecha"
    t.time     "inicio_tiempo"
    t.string   "modo_ganar"
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
