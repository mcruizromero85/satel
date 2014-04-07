require 'spec_helper'

describe "encuentros/new" do
  before(:each) do
    assign(:encuentro, stub_model(Encuentro,
      :estado => "MyString",
      :posicion_en_ronda => 1,
      :id_inscripcion_gamer_a => 1,
      :id_inscripcion_gamer_b => 1,
      :id_inscripcion_gamer_ganador => 1
    ).as_new_record)
  end

  it "renders new encuentro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", encuentros_path, "post" do
      assert_select "input#encuentro_estado[name=?]", "encuentro[estado]"
      assert_select "input#encuentro_posicion_en_ronda[name=?]", "encuentro[posicion_en_ronda]"
      assert_select "input#encuentro_id_inscripcion_gamer_a[name=?]", "encuentro[id_inscripcion_gamer_a]"
      assert_select "input#encuentro_id_inscripcion_gamer_b[name=?]", "encuentro[id_inscripcion_gamer_b]"
      assert_select "input#encuentro_id_inscripcion_gamer_ganador[name=?]", "encuentro[id_inscripcion_gamer_ganador]"
    end
  end
end
