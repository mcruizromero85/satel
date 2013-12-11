require 'rspec'
require 'active_support/core_ext/date'

require_relative '../../app/helpers/torneos_helper'


#* Los torneos deben listarse en orden descendente respecto a la fecha de cierre de inscripción, los mas cercanos a iniciar deben salir primeros.
#* Las fechas de cierre de inscripción, listadas por cada torneo, deben estar expresado en temporizadores de cuenta regresiva.
#* Las unidades y redondeo a manejar para los contadores es en base a las siguientes condicionales:
#** Si es de 2 días a más, solo se mostrará en formato de días lo que falta para cerrar la inscripción del torneo, ejemplo: 3 días, 4 días, etc.
#** Si es menor a 2 días, se mostrará el día y la hora bajo los siguientes ejemplos: 1d 12h, 1d 3h
#** Si es menor a 1 día, se mostrará la hora, los minutos y los segundos pendientes en línea, ejemplo: 3h 25m 35s
#* Los redondeo es realizado al mayor
#* El listado máximo de torneos a mostrar es de 20 registros.

describe TorneosHelper do
   fecha_actual_con_milisegundos=Time.new.to_i

  it 'should return 2d if the tournament start in 2 days' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 48)))).to eq "2d"
  end

  it 'should return 3d if the tournament start in 3 days' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 72)))).to eq "3d"
  end

  it 'should return 4d if the tournament start in 4 days' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 96)))).to eq "4d"
  end

  it 'should return 5d if the tournament start in 5 days' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 120)))).to eq "5d"
  end

  it 'should return 35d if the tournament start in 35 days' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 840)))).to eq "35d"
  end

  it 'should return 1d 12h if the tournament start in 36 hours' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 36)))).to eq "1d 12h"
  end

  it 'should return 1d 12h if the tournament start in 36 hours' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + (60 * 60 * 27)))).to eq "1d 3h"
  end

  it 'should return 3h 25m 35s if the tournament start in 12335 segundos' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + 12335))).to eq "3h 25m 35s"
  end

  it 'should return 4h 1m 39s if the tournament start in 12335 segundos' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_milisegundos + 14499))).to eq "4h 1m 39s"
  end
  #it 'should return 35d if the tournament start in 35 days' do
  #  expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.now.to_i  ).to eq "35d"
  #end

end