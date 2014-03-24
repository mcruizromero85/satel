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

ActiveRecord::Schema.define(version: 20140323192709) do

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
    t.integer  "gamer_id"
    t.integer  "torneo_id"
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
    t.string   "modo_ganar"
    t.integer  "torneo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torneos", force: true do |t|
    t.string   "titulo"
    t.string   "paginaweb"
    t.integer  "vacantes"
    t.date     "cierre_inscripcion_fecha"
    t.time     "cierre_inscripcion_tiempo"
    t.date     "cierre_check_in_fecha"
    t.time     "cierre_check_in_tiempo"
    t.date     "inicio_torneo_fecha"
    t.time     "inicio_torneo_tiempo"
    t.integer  "id_gamer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
