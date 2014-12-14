require 'spec_helper'

describe "datos_inscripcion_registrados/new" do
  before(:each) do
    assign(:datos_inscripcion_registrado, stub_model(DatosInscripcionRegistrado,
      :datos_inscripcion_id => 1,
      :valor => "MyString",
      :inscripcion_id => 1
    ).as_new_record)
  end

  it "renders new datos_inscripcion_registrado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", datos_inscripcion_registrados_path, "post" do
      assert_select "input#datos_inscripcion_registrado_datos_inscripcion_id[name=?]", "datos_inscripcion_registrado[datos_inscripcion_id]"
      assert_select "input#datos_inscripcion_registrado_valor[name=?]", "datos_inscripcion_registrado[valor]"
      assert_select "input#datos_inscripcion_registrado_inscripcion_id[name=?]", "datos_inscripcion_registrado[inscripcion_id]"
    end
  end
end
