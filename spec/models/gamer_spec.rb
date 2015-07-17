require 'spec_helper'

describe Gamer do

  it 'Para identificar si estoy inscrito en un torneo' do
    torneo = FactoryGirl.create(:torneo)
    gamer = FactoryGirl.create(:gamer)
    inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado')
    expect(gamer.esta_confirmado(torneo)).to eq true
  end

  it 'Obtener contrincante actual' do
  	torneo = FactoryGirl.create(:torneo)
    4.times do | contador |      
      gamer = FactoryGirl.create(:gamer, nick: 'Mateo ' + (contador + 1).to_s)
      inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado', etiqueta_llave: 'Mateo ' + (contador + 1).to_s)
    end
    torneo.generar_encuentros(false)
    gamer = Gamer.find_by(nick: 'Mateo 1')
		expect(gamer.contrincante_inscrito_actual(torneo).etiqueta_llave).to eq 'Mateo 2'  	
  end

end
