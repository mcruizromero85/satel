require 'net/http'

class Partida < ActiveRecord::Base
  belongs_to :encuentro
  before_create :armar_url_heroes_draft
  def existe_debate
    flag_gano_gamerinscritoa && flag_gano_gamerinscritob
  end

  def armar_url_heroes_draft
    #url_heroes_draft = 'http://heroesdraft.com/create.php'
    #uri = URI.parse('http://heroesdraft.com/create.php')
    #http = Net::HTTP.new(uri.host, uri.port)
    #request = Net::HTTP::Post.new(uri.request_uri)

    #request.set_form_data(mapSelectType: '0', numBans: '1', posted: 'newMatch', startType: '0', teamOne: encuentro.gamerinscritoa.etiqueta_llave, teamTwo: encuentro.gamerinscritob.etiqueta_llave, tournament: encuentro.ronda.torneo.titulo)
    #response = http.request(request)
    #id_key_partida_heroes_draft = response['location']
    #uri = URI(url_heroes_draft.to_s + id_key_partida_heroes_draft.to_s)
    #response_partida_creada = Net::HTTP.get_response(uri)
    #self.field1 = response_partida_creada.body.scan(/value="(.*)"/)[0][0].to_s
    #self.field2 = response_partida_creada.body.scan(/value="(.*)"/)[1][0].to_s
    #self.field3 = response_partida_creada.body.scan(/value="(.*)"/)[2][0].to_s
  end
end
