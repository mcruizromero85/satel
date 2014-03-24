require 'spec_helper'

describe "inscripcions/new" do
  before(:each) do
    assign(:inscripcion, stub_model(Inscripcion,
      :estado_confirmacion => "MyString",
      :peso_participacion => 1,
      :gamer_id => 1,
      :torneo_id => 1
    ).as_new_record)
  end

  it "renders new inscripcion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inscripcions_path, "post" do
      assert_select "input#inscripcion_estado_confirmacion[name=?]", "inscripcion[estado_confirmacion]"
      assert_select "input#inscripcion_peso_participacion[name=?]", "inscripcion[peso_participacion]"
      assert_select "input#inscripcion_gamer_id[name=?]", "inscripcion[gamer_id]"
      assert_select "input#inscripcion_torneo_id[name=?]", "inscripcion[torneo_id]"
    end
  end
end
