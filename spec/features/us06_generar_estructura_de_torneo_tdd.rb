require "spec_helper"
require 'active_support/core_ext/date'

require_relative '../../app/helpers/torneos_helper'

describe TorneosHelper do
  
  it 'Obtener posiciones de brackets para 4 vacantes de tipo 1' do    
    resultado=TorneosHelper.obtener_posicion_de_ronda_por_ranking(4,1)
    expect(resultado).to eq [1,3,4,2] 
  end

  it 'Obtener posiciones de brackets para 8 vacantes de tipo 1' do    
    resultado=TorneosHelper.obtener_posicion_de_ronda_por_ranking(8,1)
    expect(resultado).to eq [1,7,5,3,4,6,8,2]
  end

  it 'Obtener posiciones de brackets para 16 vacantes de tipo 1' do    
    resultado=TorneosHelper.obtener_posicion_de_ronda_por_ranking(16,1)
    expect(resultado).to eq [1,15,7,9,5,11,3,13,4,14,8,10,6,12,16,2]
  end

  it 'Obtener posiciones de brackets para 32 vacantes de tipo 1' do    
    resultado=TorneosHelper.obtener_posicion_de_ronda_por_ranking(32,1)
    expect(resultado).to eq [1,31,9,13,19,5,27,7,25,15,17,11,21,3,29,4,30,12,22,16,18,8,26,6,28,14,20,10,24,2,32]
  end


end