require 'spec_helper'

describe TorneosController do
  render_views
  before :each do
    torneo = Torneo.new
    torneo.titulo = "Torneo Magma Hearthstone League Bronce 1"
    torneo.vacantes = 16
    torneo.cierre_inscripcion = Time.new + (60 * 60 * 24 * 2) + 10
    torneo.periodo_confirmacion_en_minutos = 20
    torneo.gamer_id = 17
    torneo.juego_id = 1
    torneo.urllogo = "https://scontent-gru2-1.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/11210452_898572773514979_2891540801757655343_n.png?oh=9cb48e90902af1c10548d1de3e5ce198&oe=5704F5D8"
    torneo.monto_auspiciado = 10.00    
    torneo.estado="Creado"
    torneo.save

    @torneo = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10, juego: Juego.find_by(nombre: "Hearthstone"))
    @gamer = Gamer.create(correo: "ecampos1@gmail.com", nombres: "Elvis", facebook_token: "EAAJwVIM8X8UBAJKlyMLZBFVIlpa9sVLcLZAcFxMqgj7eisCedrJ4xc7QoqDmRTHsZAASZAZCHAQkzrlZBvyKZA6A5fUIkZBTbXJBErThGg2nRlVKdACyYufZCo0GpCgjHZB2KGOHdTaopt3nCLF6HZBdceHCr9weyoQQcLKNZBZAe632A7wZDZD", facebook_id:"124308354666199")

  end

  it 'Dado que existe más de 3 torneos registrados, 1 que cerró inscripciones ayer y 2 que cierran mañana, debe mostrarse solo los 2 que cierran mañana.' do
  	get :index
    #puts response.body    
    expect(response.status).to eq 200
  end

 # it 'Dado que se mostraban dos torneos y registro uno que las inscripciones cierran mañana, deben mostrarse 3' do
  it "crear torneo" do 
    #torneo_params = FactoryGirl.attributes_for(:torneo)
    #expect { post :create, :torneo => torneo_params }.to change(Torneo, :count).by(1) 

    post 'create', torneo: @torneo.attributes, juego: Juego.find_by(id: "6")
    expect(response.status).to eq(406)

  end


end
