require 'spec_helper'

describe "datos_inscripciones/show" do
  before(:each) do
    @datos_inscripcion = assign(:datos_inscripcion, stub_model(DatosInscripcion,
      :inscripcion_id => 1,
      :nombre_dato => "Nombre Dato",
      :valor_dato => "Valor Dato"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Nombre Dato/)
    expect(rendered).to match(/Valor Dato/)
  end
end
