require 'spec_helper'

describe InscripcionesController do
  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @gamer = Gamer.create(correo: "mcruizromero@gmail.com", nombres: "Mauro")
    authentication = Authentication.new(provider: 'developer', uid: 'mcruizromero@gmail.com', gamer: @gamer)
    authentication.save
    session[:gamer_id] = @gamer.id
    @torneo = FactoryGirl.build(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10)
    @torneo.juego = Juego.find_by(nombre: "Hearthstone")
    @torneo.save
  end

  it 'Inscribirme a un torneo' do        
    inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269'))
    post 'create', inscripcion: inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id
    expect(response.status).to eq(201)
  end

  it 'Inscribirme a un torneo sin battletag' do    
    inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new)
    post 'create', inscripcion: inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id
    expect(response.status).to eq(406)
  end

  it 'Inscribirme a un torneo con battletag errado' do
    inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new(battletag: 'aaaa'))
    post 'create', inscripcion: inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id
    expect(response.status).to eq(406)
  end

end
