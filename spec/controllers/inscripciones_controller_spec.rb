require 'spec_helper'

describe InscripcionesController do
  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @gamer = Gamer.create(correo: "mcruizromero@gmail.com", nombres: "Mauro")
    authentication = Authentication.create(provider: 'developer', uid: 'mcruizromero@gmail.com', gamer: @gamer)
    session[:gamer_id] = @gamer.id
    @torneo = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10, juego: Juego.find_by(nombre: "Hearthstone"))
  end

  it 'Inscribirme a un torneo' do        
    inscripcion = Inscripcion.new(torneo: @torneo)
    post 'create', inscripcion: inscripcion.attributes, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269').attributes, gamer: Gamer.new(correo: @gamer.correo).attributes
    expect(response.status).to eq(201)
  end

  it 'Inscribirme a un torneo, donde ya me inscribí' do
    inscripcion = Inscripcion.new(torneo: @torneo)
    post 'create', inscripcion: inscripcion.attributes, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269').attributes, gamer: Gamer.new(correo: @gamer.correo).attributes
    expect(response.status).to eq(201)
    post 'create', inscripcion: inscripcion.attributes, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269').attributes, gamer: Gamer.new(correo: @gamer.correo).attributes
    expect(response.status).to eq(406)
  end

  it 'Inscribirme a un torneo sin battletag' do    
    inscripcion = Inscripcion.new(torneo: @torneo)
    post 'create', inscripcion: inscripcion.attributes, hearthstone_form: HearthstoneForm.new.attributes, gamer: Gamer.new(correo: @gamer.correo).attributes
    expect(response.status).to eq(406)
  end

  it 'Inscribirme a un torneo con battletag errado' do
    inscripcion = Inscripcion.new(torneo: @torneo)
    post 'create', inscripcion: inscripcion.attributes, hearthstone_form: HearthstoneForm.new(battletag: 'aaaa').attributes, gamer: Gamer.new(correo: @gamer.correo).attributes
    expect(response.status).to eq(406)
  end

  describe 'Tests de consultas y confirmacion' do
    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
      inscripcion = Inscripcion.new(torneo: @torneo)
      post 'create', inscripcion: inscripcion.attributes, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269').attributes, gamer: Gamer.new(correo: @gamer.correo).attributes
    end

    it 'Consultar inscripcion por torneo y gamer en sesion' do
      get :show_by_tournament, id_torneo: @torneo.id    
      expect(response.status).to eq 200
    end

    it 'Consultar inscripcion inexistente por torneo y gamer en sesion' do
      get :show_by_tournament, id_torneo: -99
      expect(response.status).to eq 404
    end

    it 'Confirmar un torneo' do
      post 'confirmar', id_torneo: @torneo.id
      expect(response.status).to eq(201)
    end
  end

end
