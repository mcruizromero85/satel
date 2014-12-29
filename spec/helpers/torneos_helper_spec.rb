require 'spec_helper'
require 'util_tests'

describe TorneosHelper do

  it 'Generar llaves de 8 jugadores en primera ronda' do
    torneo = torneo_iniciado_con_vacantes_confirmadas
    reportar_resultado_encuentro_por_ronda_llave(torneo, 0, 1)
    expect(TorneosHelper.obtener_array_para_resultado_llaves(torneo).to_s).to eq '[[[0, 0, 1], [1, 0, 2], [0, 0, 3], [0, 0, 4]], [[1, 0, 5], [0, 0, "0"]], [[0, 0, "0"]]]'
  end

  it 'Generar arreglo de llaves con 4 jugadores y 4 vacantes' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3))
    torneo.save
    generar_inscripciones_confirmadas(4, torneo)
    torneo.generar_encuentros
    torneo.estado = 'Iniciado'
    torneo.save
    array_de_solo_4_gamers = '[["Matt","Matt"],["Matt","Matt"]]'
    expect(TorneosHelper.array_para_llaves(torneo)).to eq array_de_solo_4_gamers
  end

  it 'Generar arreglo de llaves con 3 jugadores y 4 vacantes' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3))
    torneo.save
    generar_inscripciones_confirmadas(3, torneo)
    torneo.generar_encuentros
    torneo.estado = 'Iniciado'
    torneo.save
    array_de_solo_3_gamers = '[["Matt","Matt"],["Matt",""]]'
    expect(TorneosHelper.array_para_llaves(torneo)).to eq array_de_solo_3_gamers
  end

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

  it 'Cierre de inscripciones menores a 2 días con horas y segundos' do
    fecha_actual = Time.new
    en_35_horas = fecha_actual + (60 * 60 * 35)
    en_27_horas = fecha_actual + (60 * 60 * 27)
    en_12335_sec = fecha_actual + 11_375
    en_14499_sec = fecha_actual + 14_499
    expect(TorneosHelper.formato_cuenta_regresiva(en_35_horas)).to eq '1d 11h'
    expect(TorneosHelper.formato_cuenta_regresiva(en_27_horas)).to eq '1d 3h'
    expect(TorneosHelper.formato_cuenta_regresiva(en_12335_sec)).to eq '3h 9m 35s'
    expect(TorneosHelper.formato_cuenta_regresiva(en_14499_sec)).to eq '4h 1m 39s'
  end

  it 'Redondeado al mayor para cierre de inscripciones mayores a 2 días' do
    fecha_actual = Time.new
    en_59_horas = fecha_actual + (60 * 60 * 59)
    en_66_horas = fecha_actual + (60 * 60 * 66)
    expect(TorneosHelper.formato_cuenta_regresiva(en_59_horas)).to eq '2d'
    expect(TorneosHelper.formato_cuenta_regresiva(en_66_horas)).to eq '3d'
  end



end
