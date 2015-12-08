require 'spec_helper'

describe Ronda do
  it 'Obtener cantidad de encuentros por ronda' do
    torneo = FactoryGirl.create(:torneo, vacantes: 16)
    torneo.asignar_valores_por_defectos
    expect(RondasHelper.win_format_final(torneo)).to eq "BO5"
    expect(RondasHelper.win_format_semifinal(torneo)).to eq "BO3"
    expect(RondasHelper.win_format_others_rounds(torneo)).to eq "BO3"
  end

  it 'Obtener cantidad de encuentros por ronda' do
    torneo = FactoryGirl.create(:torneo, vacantes: 8)
    torneo.asignar_valores_por_defectos
    expect(RondasHelper.win_format_final(torneo)).to eq "BO3"
    expect(RondasHelper.win_format_semifinal(torneo)).to eq "BO3"
    expect(RondasHelper.win_format_others_rounds(torneo)).to eq "BO1"
  end

end
