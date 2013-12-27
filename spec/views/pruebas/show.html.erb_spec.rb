require 'spec_helper'

describe "pruebas/show" do
  before(:each) do
    @prueba = assign(:prueba, stub_model(Prueba,
      :titulo => "Titulo",
      :descripcion => "Descripcion",
      :formato => "Formato",
      :modalidad => "Modalidad",
      :juego_id => 1,
      :modalidad_reporte_victoria => "Modalidad Reporte Victoria",
      :vacantes => 2,
      :inicio_torneo_tiempo => "Inicio Torneo Tiempo"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Titulo/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/Formato/)
    expect(rendered).to match(/Modalidad/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Modalidad Reporte Victoria/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Inicio Torneo Tiempo/)
  end
end
