require 'spec_helper'

describe "inscripciones/edit" do
  before(:each) do
    @inscripcion = assign(:inscripcion, stub_model(Inscripcion,
      :torneo_id => 1,
      :gamer_id => 1
    ))
  end

  it "renders the edit inscripcion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inscripcion_path(@inscripcion), "post" do
      assert_select "input#inscripcion_torneo_id[name=?]", "inscripcion[torneo_id]"
      assert_select "input#inscripcion_gamer_id[name=?]", "inscripcion[gamer_id]"
    end
  end
end
