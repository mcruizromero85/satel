class Gamer < ActiveRecord::Base
  has_many :torneos
  has_many :inscripciones
  has_many :authentications, autosave: true
  validates :battletag, format: { with: /\A\D.{2,11}#\d{4}\Z/, message: ', El battle tag debe tener el formato nick#1234' }, :unless => :force_submit
  validates :correo, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: ', Tu correo no tiene el formato correcto' }, :unless => :force_submit
  attr_accessor :force_submit
  
  def self.buscar_o_crear_free_win(nick_free_win)
    gamer = Gamer.find_by(nick: nick_free_win)
    if gamer.nil?
      Gamer.create(nick: nick_free_win, correo: nick_free_win + '@freewin.com', nombres: nick_free_win)
    else
      gamer
    end
  end

  def reporto_ganar_partida_actual_el_contrincante(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    encuentro =  encuentro_actual(torneo)
    partida = encuentro.partida_actual
    encuentro.gamerinscritoa == inscripcion && partida.flag_gano_gamerinscritob || encuentro.gamerinscritob == inscripcion && partida.flag_gano_gamerinscritoa
  end

  def reporto_ganar_partida_actual(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    encuentro =  encuentro_actual(torneo)
    partida = encuentro.partida_actual
    encuentro.gamerinscritoa == inscripcion && partida.flag_gano_gamerinscritoa || encuentro.gamerinscritob == inscripcion && partida.flag_gano_gamerinscritob
  end

  def link_heroes_draft_partida_actual(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    encuentro =  encuentro_actual(torneo)
    partida = encuentro.partida_actual
    if encuentro.gamerinscritoa == inscripcion
      partida.field1
    else
      partida.field2
    end
  end

  def esta_listo_contrincante_en_encuentro_actual(torneo)
    encuentro = encuentro_actual(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    encuentro.gamerinscritoa == inscripcion && encuentro.flag_listo_gamerb || encuentro.gamerinscritob == inscripcion && encuentro.flag_listo_gamera
  end

  def esta_listo_en_encuentro_actual(torneo)
    encuentro = encuentro_actual(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    encuentro.gamerinscritoa == inscripcion && encuentro.flag_listo_gamera || encuentro.gamerinscritob == inscripcion && encuentro.flag_listo_gamerb
  end

  def gane_el_torneo(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    Encuentro.find_by(gamerinscrito_ganador: inscripcion, ronda: torneo.rondas.last)
  end

  def etiqueta_para_bracket
    if nick.nil? || nick == ''
      return nombres
    else
      return nick
    end
  end

  def esta_inscrito(torneo)
    true if Inscripcion.find_by(torneo_id: torneo.id, gamer_id: id, estado: 'No Confirmado')
  end

  def esta_confirmado(torneo)
    true if Inscripcion.find_by(torneo_id: torneo.id, gamer_id: id, estado: 'Confirmado')
  end

  def etiqueta_para_chat(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    if torneo.gamer == self
      nombres + '(Admin)'
    elsif !inscripcion.nil?
      inscripcion_en_torneo(torneo).etiqueta_chat
    else
      nombres + '(Invitado)'
    end
  end

  def etiqueta_llave(torneo)
    if torneo.gamer == self
      nombres + '(Admin)'
    else
      inscripcion_en_torneo(torneo).etiqueta_llave
    end
  end

  def contrincante_inscrito_actual(torneo)
    encuentro = encuentro_actual(torneo)
    if encuentro.gamerinscritoa == inscripcion_en_torneo(torneo)
      encuentro.gamerinscritob
    else
      encuentro.gamerinscritoa
    end
  end

  def encuentro_actual(torneo)
    Encuentro.encuentro_actual_por_inscrito(inscripcion_en_torneo(torneo))
  end

  def inscripcion_en_torneo(torneo)
    Inscripcion.find_by(torneo_id: torneo.id, estado: 'Confirmado', gamer_id: id)
  end

  def esta_inscrito_o_confirmado(torneo)
    Inscripcion.find_by(torneo_id: torneo.id, gamer_id: id)
  end

end
