require 'spec_helper'
require 'util_tests'

describe Inscripcion do
  
  before :each do
    @torneo = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10)
    @torneo.juego = Juego.find_by(nombre: "Hearthstone")
    @gamer = Gamer.create(correo: "mcruizromero@gmail.com", nombres: "Mauro")    
  end

  it 'Inscripción a un torneo sin formulario asociado' do
    @gamer.battletag = "kripty#1269"
    inscripcion = FactoryGirl.build(:inscripcion, torneo: @torneo, gamer: @gamer)
    expect(inscripcion.inscribir).to eq false
  end

  it 'Inscripción a un torneo con battletag errado' do
    hearthstone_form = HearthstoneForm.new(battletag: 'aaaa')
    inscripcion = FactoryGirl.build(:inscripcion, torneo: @torneo, gamer: @gamer, hearthstone_form: hearthstone_form)
    expect(inscripcion.valid?).to eq false
  end

  it 'Inscripción a un torneo hearthstone correcto' do
    hearthstone_form = HearthstoneForm.new(battletag: 'Kripty#1269')
    inscripcion = FactoryGirl.build(:inscripcion, torneo: @torneo, gamer: @gamer, hearthstone_form: hearthstone_form)
    expect(inscripcion.valid?).to eq true
  end
end
