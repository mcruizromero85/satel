require 'spec_helper'

describe "datos_inscripcion_registrados/show" do
  before(:each) do
    @datos_inscripcion_registrado = assign(:datos_inscripcion_registrado, stub_model(DatosInscripcionRegistrado,
      :datos_inscripcion_id => 1,
      :valor => "Valor",
      :inscripcion_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Valor/)
    expect(rendered).to match(/2/)
  end
end
