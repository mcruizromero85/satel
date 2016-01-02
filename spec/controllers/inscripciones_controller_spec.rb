require 'spec_helper'

describe InscripcionesController do
  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @gamer = Gamer.create(correo: "mcruizromero@gmail.com", nombres: "Mauro")

    authentication = Authentication.new(provider: 'developer', uid: 'mcruizromero@gmail.com', gamer: @gamer)
    authentication.save
    session[:gamer_id] = @gamer.id
    puts "session[:gamer_id]: " + session[:gamer_id].to_s 
    @torneo = FactoryGirl.build(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10)
    @torneo.juego = Juego.find_by(nombre: "Hearthstone")
    @torneo.save
  end

  it 'Inscribirme a un torneo' do    
    @gamer.battletag = "kripty#1269"
    inscripcion = Inscripcion.new(torneo: @torneo, gamer: @gamer, hearthstone_form: HearthstoneForm.new(battletag: 'Kripty#1269'))
    post 'create', inscripcion: inscripcion.to_json(:include => [:gamer, :hearthstone_form, :torneo])
    expect(response.status).to eq(201)
  end

  it 'Inscribirme a un torneo sin battletag' do    
    inscripcion = Inscripcion.new(torneo: @torneo,gamer: @gamer)
    post 'create', inscripcion: inscripcion.attributes, id_torneo: @torneo.id, gamer: @gamer.attributes
    expect(response.status).to eq(406)
  end

  it 'Inscribirme a un torneo con battletag errado' do
    @gamer.battletag = "aaaaaa"
    inscripcion = Inscripcion.new(torneo: @torneo,gamer: @gamer)    
    post 'create', inscripcion: inscripcion.attributes, id_torneo: @torneo.id, gamer: @gamer.attributes
    expect(response.status).to eq(406)
  end

  it 'has a 200 status code' do
  	get :index
    expect(response.status).to eq 200
  end

  describe 'Tests Show' do
  	before do
  	  @torneo = FactoryGirl.create(:torneo, vacantes: 8)
  	end 

  	it 'has a 200 status code' do	  
  	  get :show, id: @torneo.id
  	  expect(response.status).to eq 200
  	end

  	it 'has a 401 status code' do	  
  	  get :show, id: -1
  	  expect(response.status).to eq 404
  	end

  	it 'has a 200 status code' do	  
  	  get :show, id: @torneo.id
  	  json = JSON.parse(response.body)
  	  expect(json['estado']).to eq 'Creado'
  	end

  end

  it 'has a 200 status code' do
  	torneo = FactoryGirl.build(:torneo, vacantes: 8)
  	post :create, torneo: FactoryGirl.attributes_for(:torneo), juego: FactoryGirl.attributes_for(:juego)    
    expect(response.status).to eq(201)
  end
end
