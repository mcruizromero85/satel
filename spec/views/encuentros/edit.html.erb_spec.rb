require 'spec_helper'

describe "encuentros/edit" do
  before(:each) do
    @encuentro = assign(:encuentro, stub_model(Encuentro,
      :gamera_id => 1,
      :gamerb_id => 1,
      :posicion_en_ronda => 1,
      :id_ronda => 1,
      :flag_ganador => "MyString",
      :descripcion => "MyString",
      :encuentro_anterior_a_id => 1,
      :encuentro_anterior_b_id => "MyString"
    ))
  end

  it "renders the edit encuentro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", encuentro_path(@encuentro), "post" do
      assert_select "input#encuentro_gamera_id[name=?]", "encuentro[gamera_id]"
      assert_select "input#encuentro_gamerb_id[name=?]", "encuentro[gamerb_id]"
      assert_select "input#encuentro_posicion_en_ronda[name=?]", "encuentro[posicion_en_ronda]"
      assert_select "input#encuentro_id_ronda[name=?]", "encuentro[id_ronda]"
      assert_select "input#encuentro_flag_ganador[name=?]", "encuentro[flag_ganador]"
      assert_select "input#encuentro_descripcion[name=?]", "encuentro[descripcion]"
      assert_select "input#encuentro_encuentro_anterior_a_id[name=?]", "encuentro[encuentro_anterior_a_id]"
      assert_select "input#encuentro_encuentro_anterior_b_id[name=?]", "encuentro[encuentro_anterior_b_id]"
    end
  end
end
