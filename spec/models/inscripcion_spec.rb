require 'spec_helper'
require 'util_tests'

describe Inscripcion do
  it 'Dado que confirmo mi participación estando en puesto 5 de 4 vacantes,entonces debería ver el mensaje que estoy en cola' do
    torneo = FactoryGirl.build(:torneo, vacantes: 4, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.save
    generar_inscripciones_confirmadas(4, torneo)
    inscripcion = FactoryGirl.create(:inscripcion, torneo: torneo)
    inscripcion.estado = 'Confirmado'
    inscripcion.save
    expect(inscripcion.mensaje_inscripcion.index('estás en cola') > 0).to eq true
  end
end
