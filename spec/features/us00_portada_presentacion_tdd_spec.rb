require "spec_helper"
require 'active_support/core_ext/date'

require_relative '../../app/helpers/torneos_helper'

describe TorneosHelper do
   fecha_actual_con_segundos=Time.new.to_i

  it 'Transformar fechas de cierre de inscripciones mayores a 2 días a formato de cuenta regresiva' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 48)))).to eq "2d"    
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 72)))).to eq "3d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 96)))).to eq "4d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 120)))).to eq "5d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 840)))).to eq "35d"
  end

  it 'Transformar fechas de cierre de inscripciones menores a 2 días a formato de cuenta regresiva' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 35)))).to eq "1d 11h"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 27)))).to eq "1d 3h"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + 12335))).to eq "3h 25m 35s"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + 14499))).to eq "4h 1m 39s"
  end

  it 'Transformar fechas de cierre de inscripciones mayores a 2 días a formato de cuenta regresiva, pero redondeado al mayor' do
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 59)))).to eq "2d"
    expect(TorneosHelper.obtenerFormatoCuentaRegresivaHastaLaFecha(Time.at(fecha_actual_con_segundos + (60 * 60 * 66)))).to eq "3d"
  end


end