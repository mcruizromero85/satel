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
    inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269'))
    post 'create', inscripcion: inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id
    expect(response.status).to eq(201)
  end

  it 'Inscribirme a un torneo, donde ya me inscribí' do
    inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269'))
    post 'create', inscripcion: inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id
    expect(response.status).to eq(201)
    post 'create', inscripcion: inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id    
    expect(response.status).to eq(406)
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

  describe 'Tests de consultas y confirmacion' do
    before do
      @inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269'))
      post 'create', inscripcion: @inscripcion.to_json(:include => :hearthstone_form).gsub('hearthstone_form','hearthstone_form_attributes') , id_torneo: @torneo.id      
    end

    it 'Consultar inscripcion por torneo y gamer en sesion' do
      get :show, id_torneo: @torneo.id    
      expect(response.status).to eq 200
    end

    it 'Consultar inscripcion inexistente por torneo y gamer en sesion' do
      get :show, id_torneo: -99
      expect(response.status).to eq 404
    end

    it 'Confirmar un torneo' do
      get :show, id_torneo: @torneo.id
      post 'confirmar', id_inscripcion: Inscripcion.new(JSON.parse(response.body)).id
      expect(response.status).to eq(201)
    end
  end

end
