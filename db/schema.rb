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

ActiveRecord::Schema.define(version: 20141020220459) do

  create_table "gamers", force: true do |t|
    t.string   "nick"
    t.string   "correo"
    t.string   "nombres"
    t.string   "apellidos"
    t.date     "fecha_ultimo_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.integer  "gamer_id"
    t.foreign_key :gamers
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "juegos", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torneos", force: true do |t|
    t.string   "titulo"
    t.string   "paginaweb"
    t.integer  "vacantes"
    t.datetime "cierre_inscripcion_fecha"
    t.datetime "cierre_inscripcion_tiempo"
    t.integer  "periodo_confirmacion_en_minutos"
    t.string   "tipo_torneo"
    t.string   "tipo_generacion"
    t.integer  "gamer_id"
    t.integer  "juego_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.foreign_key :juegos
    t.foreign_key :gamers
  end

  create_table "rondas", force: true do |t|
    t.integer  "numero"
    t.date     "inicio_fecha"
    t.time     "inicio_tiempo"
    t.string   "modo_ganar"
    t.integer  "torneo_id"
    t.foreign_key :torneos
    t.integer  "ronda_id"
    t.foreign_key :rondas
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encuentros", force: true do |t|
    t.integer  "gamera_id"
    t.integer  "gamerb_id"
    t.integer  "posicion_en_ronda"
    t.integer  "ronda_id"
    t.foreign_key :rondas
    t.string   "flag_ganador"
    t.string   "descripcion"
    t.integer  "encuentro_anterior_a_id"
    t.string   "encuentro_anterior_b_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inscripciones", force: true do |t|
    t.integer  "torneo_id"
    t.foreign_key :torneos
    t.integer  "gamer_id"
    t.foreign_key :gamers
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
