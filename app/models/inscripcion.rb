class Inscripcion < ActiveRecord::Base
	belongs_to :torneo
	belongs_to :gamer
end
