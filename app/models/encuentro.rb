class Encuentro < ActiveRecord::Base
	belongs_to :gamera, class_name: "Gamer", autosave: false
	belongs_to :gamerb, class_name: "Gamer", autosave: false
	belongs_to :gamer_ganador, class_name: "Gamer", autosave: false
	belongs_to :ronda, autosave: false
	belongs_to :encuentro_anterior_a, class_name: "Encuentro"
	belongs_to :encuentro_anterior_b, class_name: "Encuentro"
end

