require 'spec_helper'
require "util_tests"

describe TorneosHelper do

  it 'Generar arreglo de llaves con 4 jugadores y 4 vacantes' do
  	torneo = FactoryGirl.build(:torneo,cierre_inscripcion: Time.new+10)
  	torneo.agregar_ronda(FactoryGirl.build(:ronda,numero: 1))
  	torneo.agregar_ronda(FactoryGirl.build(:ronda,numero: 2))
  	torneo.agregar_ronda(FactoryGirl.build(:ronda,numero: 3))
  	torneo.save
  	
  	generar_inscripciones_confirmadas(4,torneo)

  	torneo.generar_encuentros
  	torneo.estado="Iniciado"
  	torneo.save

    expect(TorneosHelper.obtener_array_para_llaves(torneo)).to eq '[["Matt","Matt"],["Matt","Matt"]]'
  end

  it 'Generar arreglo de llaves con 3 jugadores y 4 vacantes' do
  	torneo = FactoryGirl.build(:torneo,cierre_inscripcion: Time.new+10)
  	torneo.agregar_ronda(FactoryGirl.build(:ronda,numero: 1))
  	torneo.agregar_ronda(FactoryGirl.build(:ronda,numero: 2))
  	torneo.agregar_ronda(FactoryGirl.build(:ronda,numero: 3))
  	torneo.save
  	
  	generar_inscripciones_confirmadas(3,torneo)

  	torneo.generar_encuentros
  	torneo.estado="Iniciado"
  	torneo.save

    expect(TorneosHelper.obtener_array_para_llaves( torneo)).to eq '[["Matt","Matt"],["Matt",""]]'
  end

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

  it 'Transformar fechas de cierre de inscripciones mayores a 2 días a formato de cuenta regresiva' do
  	fecha_actual_con_segundos=Time.new.to_i
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 48)))).to eq "2d"    
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 72)))).to eq "3d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 96)))).to eq "4d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 120)))).to eq "5d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 840)))).to eq "35d"
  end

  it 'Transformar fechas de cierre de inscripciones menores a 2 días a formato de cuenta regresiva' do
  	fecha_actual_con_segundos=Time.new.to_i
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 35)))).to eq "1d 11h"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 27)))).to eq "1d 3h"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + 12335))).to eq "3h 25m 35s"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + 14499))).to eq "4h 1m 39s"
  end

  it 'Transformar fechas de cierre de inscripciones mayores a 2 días a formato de cuenta regresiva, pero redondeado al mayor' do
  	fecha_actual_con_segundos=Time.new.to_i
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 59)))).to eq "2d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 66)))).to eq "3d"
  end

end