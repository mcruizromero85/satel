require 'spec_helper'

describe "inscripcions/index" do
  before(:each) do
    assign(:inscripcions, [
      stub_model(Inscripcion,
        :estado_confirmacion => "Estado Confirmacion",
        :peso_participacion => 1,
        :gamer_id => 2,
        :torneo_id => 3
      ),
      stub_model(Inscripcion,
        :estado_confirmacion => "Estado Confirmacion",
        :peso_participacion => 1,
        :gamer_id => 2,
        :torneo_id => 3
      )
    ])
  end

  it "renders a list of inscripcions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Estado Confirmacion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
