class DatosInscripcionRegistrado < ActiveRecord::Base
	belongs_to :datos_inscripcion
	belongs_to :inscripcion
end
