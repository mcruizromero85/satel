require 'spec_helper'
require 'util_tests'

describe TorneosHelper do

  it 'Si tengo 5 gamers confirmados, debo tener un bracket de 8 slots' do
    expect(TorneosHelper.bracket_segun_cantidad_confirmados(5)).to eq 8
  end

  it 'Si tengo 7 gamers confirmados, debo tener un bracket de 8 slots' do
    expect(TorneosHelper.bracket_segun_cantidad_confirmados(7)).to eq 8
  end

  it 'Si tengo 9 gamers confirmados, debo tener un bracket de 16 slots' do
    expect(TorneosHelper.bracket_segun_cantidad_confirmados(9)).to eq 16
  end

  it 'Si tengo 17 gamers confirmados, debo tener un bracket de 32 slots' do
    expect(TorneosHelper.bracket_segun_cantidad_confirmados(17)).to eq 32
  end

  it 'Si tengo 33 gamers confirmados, debo tener un bracket de 64 slots' do
    expect(TorneosHelper.bracket_segun_cantidad_confirmados(33)).to eq 64
  end

  it 'Cierre de inscripciones mayores a 2 días a formato de cuenta regresiva' do
    fecha_actual = Time.new
    en_48_horas = fecha_actual + (60 * 60 * 48)
    en_72_horas = fecha_actual + (60 * 60 * 72)
    en_96_horas = fecha_actual + (60 * 60 * 96)
    en_120_horas = fecha_actual + (60 * 60 * 120)
    en_840_horas = fecha_actual + (60 * 60 * 840)
    expect(TorneosHelper.formato_cuenta_regresiva(en_48_horas)).to eq '2d'
    expect(TorneosHelper.formato_cuenta_regresiva(en_72_horas)).to eq '3d'
    expect(TorneosHelper.formato_cuenta_regresiva(en_96_horas)).to eq '4d'
    expect(TorneosHelper.formato_cuenta_regresiva(en_120_horas)).to eq '5d'
    expect(TorneosHelper.formato_cuenta_regresiva(en_840_horas)).to eq '35d'
  end

  it 'Cierre de inscripciones menores a 2 días con horas y minutos' do
    fecha_actual = Time.new
    en_35_horas = fecha_actual + (60 * 60 * 35)
    en_27_horas = fecha_actual + (60 * 60 * 27)
    expect(TorneosHelper.formato_cuenta_regresiva(en_35_horas)).to eq '1d 11h'
    expect(TorneosHelper.formato_cuenta_regresiva(en_27_horas)).to eq '1d 3h'
  end

  it 'Redondeado al mayor para cierre de inscripciones mayores a 2 días' do
    fecha_actual = Time.new
    en_59_horas = fecha_actual + (60 * 60 * 59)
    en_66_horas = fecha_actual + (60 * 60 * 66)
    expect(TorneosHelper.formato_cuenta_regresiva(en_59_horas)).to eq '2d'
    expect(TorneosHelper.formato_cuenta_regresiva(en_66_horas)).to eq '3d'
  end

  # it 'Generar llaves de 16 jugadores en primera ronda, y con ganador del encuentro 5' do
  #  torneo = torneo_iniciado_con_vacantes_confirmadas(16)
  #  reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 5)
  #  torneo = Torneo.find(torneo.id)
  #  expect(TorneosHelper.obtener_array_para_resultado_llaves(torneo).to_s).to eq '[[[0, 0, 1], [0, 0, 2], [0, 0, 3], [0, 0, 4], [1, 0, 5], [0, 0, 6], [0, 0, 7], [0, 0, 8]], [[0, 0, "0"], [0, 0, "0"], [0, 1, 9], [0, 0, "0"]], [[0, 0, "0"], [0, 0, "0"]], [[0, 0, "0"]]]'
  # end

  # it 'Generar llaves de 8 jugadores en primera ronda' do
  #  torneo = torneo_iniciado_con_vacantes_confirmadas
  #  reportar_resultado_encuentro_por_ronda_llave(torneo, 1, 2)
  #  expect(TorneosHelper.obtener_array_para_resultado_llaves(torneo).to_s).to eq '[[[0, 0, 1], [1, 0, 2], [0, 0, 3], [0, 0, 4]], [[1, 0, 5], [0, 0, "0"]], [[0, 0, "0"]]]'
  # end
end
