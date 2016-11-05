require 'spec_helper'
require 'util_tests'

describe Inscripcion do
  
  before :each do
    @gamer = Gamer.create(correo: "mcruizromero@gmail.com", nombres: "Mauro", battletag: "Kripty#1234")
    @torneo_con_inscritos = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10, juego: Juego.find_by(nombre: "Hearthstone"))
    16.times do
      inscripcion = FactoryGirl.create(:inscripcion, torneo: @torneo_con_inscritos)
    end
  end
  
  it 'Inscripción a un torneo con cantidad de inscritos igual a la cantidad de vacantes del torneo' do
    @inscripcion = Inscripcion.new(gamer: @gamer, torneo: @torneo_con_inscritos)
    @inscripcion.inscribir    
    expect(@inscripcion.mensaje_inscripcion).to eq 'Tu inscripción se guardó satisfactoriamente, pero estás en cola, tu posición es "17"'
  end

end
