class Sc2Form < ActiveRecord::Base
  belongs_to :inscripcion  
  validates :race, inclusion: { in: %w(Terran Zerg Protoss), message: "Debe escoger una raza para el torneo" }
end
