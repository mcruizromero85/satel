 module ITorneoService

  def iniciar_torneo
    raise NotImplementedError.new
  end

  def obtener_torneos_para_portada
	raise NotImplementedError.new
  end

  def obtener_torneo_con_valores_inicializados
  	raise NotImplementedError.new
  end

  def generar_estructura_llaves(torneo,inscripciones)
  	raise NotImplementedError.new
  end

  def guardar_torneo(torneo,rondas)
  	raise NotImplementedError.new
  end

end