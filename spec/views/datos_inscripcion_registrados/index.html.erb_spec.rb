require 'spec_helper'

describe "datos_inscripcion_registrados/index" do
  before(:each) do
    assign(:datos_inscripcion_registrados, [
      stub_model(DatosInscripcionRegistrado,
        :datos_inscripcion_id => 1,
        :valor => "Valor",
        :inscripcion_id => 2
      ),
      stub_model(DatosInscripcionRegistrado,
        :datos_inscripcion_id => 1,
        :valor => "Valor",
        :inscripcion_id => 2
      )
    ])
  end

  it "renders a list of datos_inscripcion_registrados" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Valor".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
