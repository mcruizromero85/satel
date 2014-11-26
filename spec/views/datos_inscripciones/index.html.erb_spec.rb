require 'spec_helper'

describe "datos_inscripciones/index" do
  before(:each) do
    assign(:datos_inscripciones, [
      stub_model(DatosInscripcion,
        :inscripcion_id => 1,
        :nombre_dato => "Nombre Dato",
        :valor_dato => "Valor Dato"
      ),
      stub_model(DatosInscripcion,
        :inscripcion_id => 1,
        :nombre_dato => "Nombre Dato",
        :valor_dato => "Valor Dato"
      )
    ])
  end

  it "renders a list of datos_inscripciones" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre Dato".to_s, :count => 2
    assert_select "tr>td", :text => "Valor Dato".to_s, :count => 2
  end
end
