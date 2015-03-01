require 'spec_helper'
require 'util_tests'

describe Encuentro do

	it 'Para un torneo de 4 rondas, Al encuentro 7 de la ronda 1, le sigue el encuentro 4 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas(16)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 7)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 4
  end

	it 'Para un torneo de 4 rondas, Al encuentro 5 de la ronda 1, le sigue el encuentro 3 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas(16)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 5)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 3
  end

	it 'Para un torneo de 4 rondas, Al encuentro 1 de la ronda 1, le sigue el encuentro 1 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas(16)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 1)
  	torneo = Torneo.find(torneo.id)  
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 1
  end

	it 'Para un torneo de 3 rondas, Al encuentro 2 de la ronda 2, le sigue el encuentro 1 de la ronda 3 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 1)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 2)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 3)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 4)  	
  	torneo = Torneo.find(torneo.id)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 2, 1)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 2, 2)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[2].encuentros[0].posicion_en_ronda).to eq 1
  end

	it 'Para un torneo de 3 rondas, Al encuentro 1 de la ronda 2, le sigue el encuentro 1 de la ronda 3 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 1)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 2)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 3)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 4)  	
  	torneo = Torneo.find(torneo.id)
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 2, 1)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[2].encuentros[0].posicion_en_ronda).to eq 1
  end

	it 'Para un torneo de 3 rondas, Al encuentro 4 de la ronda 1, le sigue el encuentro 2 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 4)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 2
  end

	it 'Para un torneo de 3 rondas, Al encuentro 3 de la ronda 1, le sigue el encuentro 2 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 3)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 2
  end

	it 'Para un torneo de 3 rondas, Al encuentro 2 de la ronda 1, le sigue el encuentro 1 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 2)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 1
  end

  it 'Para un torneo de 3 rondas, Al encuentro 1 de la ronda 1, le sigue el encuentro 1 de la ronda 2 ' do
  	torneo = torneo_iniciado_con_vacantes_confirmadas
  	reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 1)
  	torneo = Torneo.find(torneo.id)
  	expect(torneo.rondas[1].encuentros[0].posicion_en_ronda).to eq 1
  end

end
