require 'spec_helper'

describe TorneosController do
  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  it 'Crear un torneo' do
    # gamer = Gamer.new(correo: "mcruizromero@gmail.com", nombres: "Mauro")
    # gamer.save
    # authentication = Authentication.new(provider: 'developer', uid: 'mcruizromero@gmail.com', gamer: gamer)
    # authentication.save
    # session[:gamer_id] = gamer.id
    # post 'create', :torneo
    # expect(response.status).to eq(200)
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
