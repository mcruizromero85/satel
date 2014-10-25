require 'spec_helper'

describe "encuentros/index" do
  before(:each) do
    assign(:encuentros, [
      stub_model(Encuentro,
        :gamera_id => 1,
        :gamerb_id => 2,
        :posicion_en_ronda => 3,
        :id_ronda => 4,
        :flag_ganador => "Flag Ganador",
        :descripcion => "Descripcion",
        :encuentro_anterior_a_id => 5,
        :encuentro_anterior_b_id => "Encuentro Anterior B"
      ),
      stub_model(Encuentro,
        :gamera_id => 1,
        :gamerb_id => 2,
        :posicion_en_ronda => 3,
        :id_ronda => 4,
        :flag_ganador => "Flag Ganador",
        :descripcion => "Descripcion",
        :encuentro_anterior_a_id => 5,
        :encuentro_anterior_b_id => "Encuentro Anterior B"
      )
    ])
  end

  it "renders a list of encuentros" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Flag Ganador".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Encuentro Anterior B".to_s, :count => 2
  end
end
