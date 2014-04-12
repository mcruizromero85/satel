class Encuentro < ActiveRecord::Base
	belongs_to :gamer_a, foreign_key: "id_inscripcion_gamer_a", class_name: "inscripcion"
	belongs_to :gamer_b, foreign_key: "id_inscripcion_gamer_b", class_name: "inscripcion"
	belongs_to :gamer_ganador, foreign_key: "id_inscripcion_gamer_ganador", class_name: "inscripcion"

end 