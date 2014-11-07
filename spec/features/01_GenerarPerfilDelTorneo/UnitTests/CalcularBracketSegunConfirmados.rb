require "spec_helper"
require_relative '../../../../app/helpers/torneos_helper'

describe TorneosHelper do

  it 'Si tengo 5 gamers confirmados, debo tener un bracket de 8 slots' do
    expect(TorneosHelper.obtener_bracket_segun_cantidad_confirmados(5)).to eq 8
  end

  it 'Si tengo 7 gamers confirmados, debo tener un bracket de 8 slots' do
    expect(TorneosHelper.obtener_bracket_segun_cantidad_confirmados(7)).to eq 8
  end

  it 'Si tengo 9 gamers confirmados, debo tener un bracket de 16 slots' do
    expect(TorneosHelper.obtener_bracket_segun_cantidad_confirmados(9)).to eq 16
  end

  it 'Si tengo 17 gamers confirmados, debo tener un bracket de 32 slots' do
    expect(TorneosHelper.obtener_bracket_segun_cantidad_confirmados(17)).to eq 32
  end

  it 'Si tengo 33 gamers confirmados, debo tener un bracket de 64 slots' do
    expect(TorneosHelper.obtener_bracket_segun_cantidad_confirmados(33)).to eq 64
  end

end
