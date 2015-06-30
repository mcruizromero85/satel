require 'spec_helper'

describe Gamer do

  it 'Para identificar si estoy inscrito en un torneo' do
    torneo = FactoryGirl.create(:torneo)
    gamer = FactoryGirl.create(:gamer)
    inscripcion = FactoryGirl.create(:inscripcion,gamer: gamer,torneo: torneo, estado: 'Confirmado')
    expect(gamer.esta_confirmado(torneo)).to eq true
  end
end
