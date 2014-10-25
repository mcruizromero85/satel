require "spec_helper"
require 'active_support/core_ext/date'

require_relative '../../../../app/helpers/torneos_helper'

describe TorneosHelper do

  it 'Generar arreglo de encuentros para 4 jugadores y 4 vacantes' do
    array_jugadores = [25, 23, 24, 18]
    expect(TorneosHelper.obtener_array_doble_de_encuentros(array_jugadores,4)).to eq [[25,23],[24,18]]
  end

  it 'Generar arreglo de encuentros para 3 jugadores y 4 vacantes' do
    array_jugadores = [25, 23, 24]
    expect(TorneosHelper.obtener_array_doble_de_encuentros(array_jugadores,4)).to eq [[25,23],[24,-1]]
  end

end
