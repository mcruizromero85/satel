require 'spec_helper'

describe "inscripcions/show" do
  before(:each) do
    @inscripcion = assign(:inscripcion, stub_model(Inscripcion,
      :estado_confirmacion => "Estado Confirmacion",
      :peso_participacion => 1,
      :gamer_id => 2,
      :torneo_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Estado Confirmacion/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
