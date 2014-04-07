require 'spec_helper'

describe "encuentros/show" do
  before(:each) do
    @encuentro = assign(:encuentro, stub_model(Encuentro,
      :estado => "Estado",
      :posicion_en_ronda => 1,
      :id_inscripcion_gamer_a => 2,
      :id_inscripcion_gamer_b => 3,
      :id_inscripcion_gamer_ganador => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Estado/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
