require 'spec_helper'

describe "pruebas/new" do
  before(:each) do
    assign(:prueba, stub_model(Prueba,
      :titulo => "MyString",
      :descripcion => "MyString",
      :formato => "MyString",
      :modalidad => "MyString",
      :juego_id => 1,
      :modalidad_reporte_victoria => "MyString",
      :vacantes => 1,
      :inicio_torneo_tiempo => "MyString"
    ).as_new_record)
  end

  it "renders new prueba form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pruebas_path, "post" do
      assert_select "input#prueba_titulo[name=?]", "prueba[titulo]"
      assert_select "input#prueba_descripcion[name=?]", "prueba[descripcion]"
      assert_select "input#prueba_formato[name=?]", "prueba[formato]"
      assert_select "input#prueba_modalidad[name=?]", "prueba[modalidad]"
      assert_select "input#prueba_juego_id[name=?]", "prueba[juego_id]"
      assert_select "input#prueba_modalidad_reporte_victoria[name=?]", "prueba[modalidad_reporte_victoria]"
      assert_select "input#prueba_vacantes[name=?]", "prueba[vacantes]"
      assert_select "input#prueba_inicio_torneo_tiempo[name=?]", "prueba[inicio_torneo_tiempo]"
    end
  end
end
