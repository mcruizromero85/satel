require 'spec_helper'

describe "pruebas/index" do
  before(:each) do
    assign(:pruebas, [
      stub_model(Prueba,
        :titulo => "Titulo",
        :descripcion => "Descripcion",
        :formato => "Formato",
        :modalidad => "Modalidad",
        :juego_id => 1,
        :modalidad_reporte_victoria => "Modalidad Reporte Victoria",
        :vacantes => 2,
        :inicio_torneo_tiempo => "Inicio Torneo Tiempo"
      ),
      stub_model(Prueba,
        :titulo => "Titulo",
        :descripcion => "Descripcion",
        :formato => "Formato",
        :modalidad => "Modalidad",
        :juego_id => 1,
        :modalidad_reporte_victoria => "Modalidad Reporte Victoria",
        :vacantes => 2,
        :inicio_torneo_tiempo => "Inicio Torneo Tiempo"
      )
    ])
  end

  it "renders a list of pruebas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Titulo".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => "Formato".to_s, :count => 2
    assert_select "tr>td", :text => "Modalidad".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Modalidad Reporte Victoria".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Inicio Torneo Tiempo".to_s, :count => 2
  end
end
