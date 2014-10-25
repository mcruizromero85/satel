require "spec_helper"
require 'active_support/core_ext/date'

require_relative '../../../../app/helpers/torneos_helper'

describe TorneosHelper do

  it 'Generar arreglo de llaves con 4 jugadores y 4 vacantes' do
    array_jugadores = ["Gissella","Mateo","Gianella","Roger"]
    expect(TorneosHelper.obtener_array_para_llaves( array_jugadores, 4)).to eq '[["Gissella","Mateo"],["Gianella","Roger"]]'
  end

  it 'Generar arreglo de llaves con 3 jugadores y 4 vacantes' do
    array_jugadores = ["Gissella","Mateo","Gianella"]
    expect(TorneosHelper.obtener_array_para_llaves( array_jugadores, 4)).to eq '[["Gissella","Mateo"],["Gianella",""]]'
  end

end
