require 'spec_helper'

describe "inscripciones/new" do
  before(:each) do
    assign(:inscripcion, stub_model(Inscripcion,
      :torneo_id => 1,
      :gamer_id => 1
    ).as_new_record)
  end

  it "renders new inscripcion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inscripciones_path, "post" do
      assert_select "input#inscripcion_torneo_id[name=?]", "inscripcion[torneo_id]"
      assert_select "input#inscripcion_gamer_id[name=?]", "inscripcion[gamer_id]"
    end
  end
end
