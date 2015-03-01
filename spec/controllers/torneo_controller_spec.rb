require 'spec_helper'

describe TorneosController do
  it "Crear un torneo" do  	
  	gamer = Gamer.new(correo: "mcruizromero@gmail.com", nombres: "Mauro")
    gamer.save
    authentication = Authentication.new(provider: 'developer', uid: 'mcruizromero@gmail.com', gamer: gamer)
    authentication.save
  	session[:gamer_id] = gamer.id

    post 'create', :torneo
    expect(response.status).to eq(200)


    #Parameters: {"utf8"=>"✓", "authenticity_token"=>"GoLae4wlQJZt6FMta+7PHquNzwdzTsMT/yDFcL0v+yw=", "torneo"=>{"titulo"=>"Torneo Bloodzone Primera Liga Dota2", "estado"=>"Creado", "paginaweb"=>"http://www.bloodzone.net/forums/f8/primera-bloodzone-league-~-dota-2-%5B2014%5D-109018/", "vacantes"=>"8", "periodo_confirmacion_en_minutos"=>"30"}, "juego"=>{"id"=>"3"}, "cierre_inscripcion_fecha"=>"21/12/2014", "cierre_inscripcion_hora"=>"02:02 AM", "ronda1"=>{"numero"=>"1", "inicio_fecha"=>"01/01/2015", "inicio_tiempo"=>"01:00 AM", "modo_ganar"=>"1"}, "ronda2"=>{"numero"=>"2", "inicio_fecha"=>"02/01/2015", "inicio_tiempo"=>"01:00 AM", "modo_ganar"=>"1"}, "ronda3"=>{"numero"=>"3", "inicio_fecha"=>"03/01/2015", "inicio_tiempo"=>"01:00 AM", "modo_ganar"=>"1"}, "commit"=>"Siguiente"}



    #Parameters: {"utf8"=>"✓", "authenticity_token"=>"GoLae4wlQJZt6FMta+7PHquNzwdzTsMT/yDFcL0v+yw=", "torneo"=>{"estado"=>"Creado"}, "datos_inscripcion0"=>{"nombre"=>"DNI"}, "commit"=>"Update Torneo", "id"=>"14"}
  end	
end