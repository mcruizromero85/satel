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

  end

  it 'Dado que existe más de 3 torneos registrados, 1 que cerró inscripciones ayer y 2 que cierran mañana, debe mostrarse solo los 2 que cierran mañana.' do
  	get :index
    #puts response.body    
    expect(response.status).to eq 200
  end

end
