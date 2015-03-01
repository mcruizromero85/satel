require 'spec_helper'

describe "datos_inscripciones/edit" do
  before(:each) do
    @datos_inscripcion = assign(:datos_inscripcion, stub_model(DatosInscripcion,
      :inscripcion_id => 1,
      :nombre_dato => "MyString",
      :valor_dato => "MyString"
    ))
  end

  it "renders the edit datos_inscripcion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", datos_inscripcion_path(@datos_inscripcion), "post" do
      assert_select "input#datos_inscripcion_inscripcion_id[name=?]", "datos_inscripcion[inscripcion_id]"
      assert_select "input#datos_inscripcion_nombre_dato[name=?]", "datos_inscripcion[nombre_dato]"
      assert_select "input#datos_inscripcion_valor_dato[name=?]", "datos_inscripcion[valor_dato]"
    end
  end
end
