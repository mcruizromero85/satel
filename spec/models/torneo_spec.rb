require 'spec_helper'
require 'util_tests'

describe Torneo do
  it 'Error con título menor a 30 caracteres' do
    torneo = FactoryGirl.build(:torneo, titulo: 'Menos de 30 Carácteres')
    torneo.save
    expect(torneo.errors[:titulo].size).to eq 1
  end

  it 'Error con título mayor a 100 caracteres' do
    torneo = FactoryGirl.build(:torneo, titulo: 'Más de 100 Carácteres' * 10)
    torneo.save
    expect(torneo.errors[:titulo].size).to eq 1
  end

  it 'Sin error con página web con formato url' do
    torneo = FactoryGirl.build(:torneo, paginaweb: 'http://www.paginaweb.com')
    torneo.save
    expect(torneo.errors[:paginaweb].size).to eq 0
  end

  it 'Error con páginaweb sin formato url' do
    torneo = FactoryGirl.build(:torneo, paginaweb: 'url sin formato')
    torneo.save
    expect(torneo.errors[:paginaweb].size).to eq 1
  end

  it 'Error con fecha cierre inscripción, fecha inscripción menor a la actual' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new - 60)
    torneo.save
    expect(torneo.errors[:cierre_inscripcion].size).to eq 1
  end

  it 'Error con el número de rondas, Las rondas deben ser equivalentes al número de vacantes' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new - 60)
    torneo.save
    expect(torneo.errors[:rondas].size).to eq 1
  end

  it 'Error cuando la fecha de primera ronda es mayor a la de cierre de inscripción' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1, inicio_fecha: (Time.new - (60 * 60 * 24 * 2)).strftime('%d/%m/%Y')))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3))
    torneo.save
    expect(torneo.errors[:cierre_inscripcion].size).to eq 1
  end

  it 'Error cuando se define una fecha y hora de inicio de ronda menor a la ronda anterior' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1, inicio_fecha: (Time.new + (60 * 60 * 24 * 2)).strftime('%d/%m/%Y')))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2, inicio_fecha: (Time.new + (60 * 60 * 24 * 1)).strftime('%d/%m/%Y')))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3))
    torneo.save
    expect(torneo.errors[:rondas].size).to eq 1
  end

  it 'Error cuando quiere iniciar un torneo con solo 3 inscritos confirmados' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3))
    torneo.save
    generar_inscripciones_confirmadas(3, torneo)
    torneo.generar_encuentros
    torneo.estado = 'Iniciado'
    torneo.save
    expect(torneo.errors[:vacantes].size).to eq 1
  end

  it 'Solo escoger los 8 primeros de 10 de los inscritos confirmados de un torneo para 8 vacantes' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3))
    torneo.save
    generar_inscripciones_confirmadas(10, torneo)
    torneo.generar_encuentros
    torneo.estado = 'Iniciado'
    torneo.save
    inscritos_que_deberian_estar = torneo.inscripciones.ids.take(8)
    torneo.rondas[0].encuentros.each do | ecuentro |
      inscritos_que_deberian_estar.delete(ecuentro.gamerinscritoa.id)
      inscritos_que_deberian_estar.delete(ecuentro.gamerinscritob.id)
    end
    expect(inscritos_que_deberian_estar.size).to eq 0
  end
end
