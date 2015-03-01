require 'spec_helper'

describe "datos_inscripciones/new" do
  before(:each) do
    assign(:datos_inscripcion, stub_model(DatosInscripcion,
      :inscripcion_id => 1,
      :nombre_dato => "MyString",
      :valor_dato => "MyString"
    ).as_new_record)
  end

  it "renders new datos_inscripcion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", datos_inscripciones_path, "post" do
      assert_select "input#datos_inscripcion_inscripcion_id[name=?]", "datos_inscripcion[inscripcion_id]"
      assert_select "input#datos_inscripcion_nombre_dato[name=?]", "datos_inscripcion[nombre_dato]"
      assert_select "input#datos_inscripcion_valor_dato[name=?]", "datos_inscripcion[valor_dato]"
    end
  end
end
