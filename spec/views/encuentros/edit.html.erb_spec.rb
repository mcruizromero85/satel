require 'spec_helper'

describe "encuentros/edit" do
  before(:each) do
    @encuentro = assign(:encuentro, stub_model(Encuentro,
      :estado => "MyString",
      :posicion_en_ronda => 1,
      :id_inscripcion_gamer_a => 1,
      :id_inscripcion_gamer_b => 1,
      :id_inscripcion_gamer_ganador => 1
    ))
  end

  it "renders the edit encuentro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", encuentro_path(@encuentro), "post" do
      assert_select "input#encuentro_estado[name=?]", "encuentro[estado]"
      assert_select "input#encuentro_posicion_en_ronda[name=?]", "encuentro[posicion_en_ronda]"
      assert_select "input#encuentro_id_inscripcion_gamer_a[name=?]", "encuentro[id_inscripcion_gamer_a]"
      assert_select "input#encuentro_id_inscripcion_gamer_b[name=?]", "encuentro[id_inscripcion_gamer_b]"
      assert_select "input#encuentro_id_inscripcion_gamer_ganador[name=?]", "encuentro[id_inscripcion_gamer_ganador]"
    end
  end
end
