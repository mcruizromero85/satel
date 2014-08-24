class Inscripcion < ActiveRecord::Base
	validates :torneo, uniqueness: { scope: :gamer, message: ", Ya estas inscrito en este torneo" }
	belongs_to :gamer
	belongs_to :torneo  , autosave: false
end
