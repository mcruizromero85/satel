module TorneosHelper
  require 'active_support/core_ext/date'
  require 'uri'

  def self.debe_mostrar_contador_estatico(fecha)
    un_dias_en_segundos = 60 * 60 * 24
    (fecha.to_i - Time.new.to_i >= un_dias_en_segundos)
  end

  def self.bracket_segun_cantidad_confirmados(cantidad_gamers_confirmados)
    if cantidad_gamers_confirmados <= 8
      8
    elsif cantidad_gamers_confirmados <= 16
      16
    elsif cantidad_gamers_confirmados <= 32
      32
    else
      64
    end
  end

  def self.obtener_array_para_resultado_llaves(torneo,ronda_inicio = 1)

    
    contador_rondas = 0
    rondas_evaluar = torneo.rondas.where('numero >= ?', ronda_inicio)
    array_id_encuentros = Array.new(rondas_evaluar.count) {}
    cantidad_de_encuentros_en_ronda = rondas_evaluar.first.encuentros.count
    rondas_evaluar.each do | ronda |
      cantidad_de_encuentros_en_ronda /= 2 if ronda.numero != 1
      array_id_encuentros_ronda = Array.new(cantidad_de_encuentros_en_ronda) { [0, 0, '0'] }
      ronda.encuentros.each do | encuentro |
        if !encuentro.gamerinscrito_ganador.nil?
          array_id_encuentros_ronda[encuentro.posicion_en_ronda - 1] = [encuentro.puntaje_de_inscrito(encuentro.gamerinscritoa), encuentro.puntaje_de_inscrito(encuentro.gamerinscritob), encuentro.id]
        else
          array_id_encuentros_ronda[encuentro.posicion_en_ronda - 1] = [0, 0, encuentro.id]
        end
      end
      array_id_encuentros[contador_rondas] = array_id_encuentros_ronda
      contador_rondas += 1
    end
    array_id_encuentros
  end

  def self.obtener_rondas_por_vacantes(vacantes)
    Math.log(vacantes, 2).ceil
  end

  def self.obtener_posicion_de_ronda_por_ranking(cantidad_vacantes, _tipo_combinacion)
    if cantidad_vacantes == 4
      return [1, 4, 3, 2]
    elsif cantidad_vacantes == 8
      return [1, 8, 5, 3, 4, 6, 7, 2]
    elsif cantidad_vacantes == 16
      return [1, 16, 7, 9, 5, 11, 3, 13, 4, 14, 8, 10, 6, 12, 2, 15]
    else
      return [1, 32, 9, 13, 19, 5, 27, 7, 25, 15, 17, 11, 21, 3, 29, 4, 30, 12, 22, 16, 18, 8, 26, 6, 28, 14, 20, 10, 24, 2, 31]
    end
  end

  def self.obtener_posicion_de_ronda_manual(cantidad_vacantes, _tipo_combinacion)
    if cantidad_vacantes == 4
      return [1, 2, 3, 4]
    elsif cantidad_vacantes == 8
      return [1, 2, 3, 4, 5, 6, 7, 8]
    elsif cantidad_vacantes == 16
      return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    else
      return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]
    end
  end

  def self.obtener_posicion_de_ronda_aleatoriamente(cantidad_vacantes, _tipo_combinacion)
    conjunto = [1, 2, 3, 4, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]
    conjunto.sample(cantidad_vacantes)
  end

  def self.formato_cuenta_regresiva(fecha_cierre_inscripcion)
    diferencia_segundos_cierre_inscripcion_y_hoy = fecha_cierre_inscripcion.to_i - Time.new.to_i
    formato_cuenta_regresiva = ''
    diferencia_dias = 0
    un_dia_en_segundos = 60 * 60 * 24
    una_hora_en_segundos = 60 * 60

    if diferencia_segundos_cierre_inscripcion_y_hoy >= un_dia_en_segundos
      diferencia_dias = (diferencia_segundos_cierre_inscripcion_y_hoy * 1.0 / 60 / 60 / 24)
      diferencia_segundos_cierre_inscripcion_y_hoy -= (diferencia_dias.floor  * un_dia_en_segundos)
      formato_cuenta_regresiva = diferencia_dias.round.to_s + 'd'
      diferencia_segundos_cierre_inscripcion_y_hoy = 0 if diferencia_dias.round >= 2
    end

    if diferencia_segundos_cierre_inscripcion_y_hoy >= una_hora_en_segundos && diferencia_dias < 2
      formato_cuenta_regresiva += ' ' if formato_cuenta_regresiva != ''
      difrencia_horas = (diferencia_segundos_cierre_inscripcion_y_hoy * 1.0 / 60 / 60)
      diferencia_segundos_cierre_inscripcion_y_hoy -= (difrencia_horas.floor *  una_hora_en_segundos)
      formato_cuenta_regresiva += difrencia_horas.round.to_s + 'h'
    end

    if diferencia_segundos_cierre_inscripcion_y_hoy > 60 && diferencia_dias < 1
      formato_cuenta_regresiva += ' ' if formato_cuenta_regresiva != ''
      diferencia_minutos = diferencia_segundos_cierre_inscripcion_y_hoy * 1.0 / 60
      formato_cuenta_regresiva += diferencia_minutos.floor.to_s + 'm'
    end
    formato_cuenta_regresiva
  end

  def self.obtener_cantidad_de_slots_segun_gamers_confirmados(gamers_confirmados)
    if gamers_confirmados <= 4
      4
    elsif gamers_confirmados <= 8
      8
    elsif gamers_confirmados <= 16
      16
    elsif gamers_confirmados <= 32
      32
    else
      64
    end
  end
end
