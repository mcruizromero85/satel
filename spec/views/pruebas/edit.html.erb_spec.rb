require 'spec_helper'

describe "pruebas/edit" do
  before(:each) do
    @prueba = assign(:prueba, stub_model(Prueba,
      :cadena => "MyString",
      :entero => 1,
      :decimal => "9.99"
    ))
  end

  it "renders the edit prueba form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", prueba_path(@prueba), "post" do
      assert_select "input#prueba_cadena[name=?]", "prueba[cadena]"
      assert_select "input#prueba_entero[name=?]", "prueba[entero]"
      assert_select "input#prueba_decimal[name=?]", "prueba[decimal]"
    end
  end
end
