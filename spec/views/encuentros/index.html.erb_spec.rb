require 'spec_helper'

describe "encuentros/index" do
  before(:each) do
    assign(:encuentros, [
      stub_model(Encuentro,
        :estado => "Estado",
        :posicion_en_ronda => 1,
        :id_inscripcion_gamer_a => 2,
        :id_inscripcion_gamer_b => 3,
        :id_inscripcion_gamer_ganador => 4
      ),
      stub_model(Encuentro,
        :estado => "Estado",
        :posicion_en_ronda => 1,
        :id_inscripcion_gamer_a => 2,
        :id_inscripcion_gamer_b => 3,
        :id_inscripcion_gamer_ganador => 4
      )
    ])
  end

  it "renders a list of encuentros" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Estado".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
