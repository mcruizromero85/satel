class Encuentro < ActiveRecord::Base
  belongs_to :gamerinscritoa, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscritob, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscrito_ganador, class_name: 'Inscripcion', autosave: false
  belongs_to :ronda, autosave: false
  belongs_to :encuentro_anterior_a, class_name: 'Encuentro'
  belongs_to :encuentro_anterior_b, class_name: 'Encuentro'
end
