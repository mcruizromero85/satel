require 'spec_helper'
require 'util_tests'

describe Torneo do

  it 'Generar array brackets con 4 jugadores confirmados' do
    torneo = FactoryGirl.create(:torneo, vacantes: 8)
    4.times do | contador |      
      gamer = FactoryGirl.create(:gamer, nick: 'Mateo ' + (contador + 1).to_s)
      inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado', etiqueta_llave: 'Mateo ' + (contador + 1).to_s)
    end    
    torneo.generar_encuentros(false)
    expect(torneo.arreglo_de_nombres_para_llaves).to eq '[["Mateo 1","Mateo 2"],["Mateo 3","Mateo 4"]]'
  end

  it 'Generar array brackets con 6 jugadores confirmados pero de 4 vacantes' do
    torneo = FactoryGirl.create(:torneo, vacantes: 4)
    6.times do | contador |
      gamer = FactoryGirl.create(:gamer, nick: 'Mateo ' + (contador + 1).to_s)
      inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado', etiqueta_llave: 'Mateo ' + (contador + 1).to_s)
    end
    torneo.generar_encuentros(false)
    expect(torneo.arreglo_de_nombres_para_llaves).to eq '[["Mateo 1","Mateo 2"],["Mateo 3","Mateo 4"]]'
  end

  it 'Generar array brackets con 6 jugadores confirmados y 8 vacantes en el torneo' do
    torneo = FactoryGirl.create(:torneo, vacantes: 8)
    7.times do | contador |
      gamer = FactoryGirl.create(:gamer, nick: 'Mateo ' + (contador + 1).to_s)
      inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado', etiqueta_llave: 'Mateo ' + (contador + 1).to_s)
    end
    torneo.generar_encuentros(false)
    expect(torneo.arreglo_de_nombres_para_llaves(false)).to eq '[["Mateo 1","Mateo 2"],["Mateo 3","Mateo 4"],["Mateo 5","Mateo 6"],["Mateo 7","Free Win"]]'
  end

  it 'Confirmo 6 gamers para un torneo de 4 vacantes, debería obtener los 4 gamers para los brackets' do
    torneo = FactoryGirl.create(:torneo, vacantes: 4)
    confirmar_gamers(torneo, 6)
    expect(Inscripcion.inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo).size).to eq 4
  end

  it 'Confirmo 6 gamers para un torneo de 4 vacantes, debería obtener los 4 primeros gamers.' do    
    torneo = FactoryGirl.create(:torneo, vacantes: 4)
    confirmar_gamers(torneo, 6)    
    4.times do | contador |
      expect(Inscripcion.inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo).any?{|inscripcion| inscripcion.etiqueta_llave == 'Mateo ' + (contador + 1).to_s}).to eq true
    end    
  end

  it 'Confirmo 6 gamers para un torneo de 8 vacantes, debería obtener los 6 gamers.' do    
    torneo = FactoryGirl.create(:torneo, vacantes: 8)
    confirmar_gamers(torneo, 6)
    expect(Inscripcion.inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo).size).to eq 6
  end
 
  it 'Error con fecha cierre inscripción, fecha inscripción menor a la actual' do
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new - 60)
    torneo.save
    expect(torneo.errors[:cierre_inscripcion].size).to eq 1
  end

  it 'Error cuando quiere iniciar un torneo con solo 3 inscritos confirmados' do

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

  private

  def confirmar_gamers(torneo, confirmaciones)
    confirmaciones.times do | contador |
      gamer = FactoryGirl.create(:gamer, nick: 'Mateo ' + (contador + 1).to_s)
      inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado', etiqueta_llave: 'Mateo ' + (contador + 1).to_s)
    end
  end
end
