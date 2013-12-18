require 'spec_helper'

describe "pruebas/new" do
  before(:each) do
    assign(:prueba, stub_model(Prueba,
      :cadena => "MyString",
      :entero => 1,
      :decimal => "9.99"
    ).as_new_record)
  end

  it "renders new prueba form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pruebas_path, "post" do
      assert_select "input#prueba_cadena[name=?]", "prueba[cadena]"
      assert_select "input#prueba_entero[name=?]", "prueba[entero]"
      assert_select "input#prueba_decimal[name=?]", "prueba[decimal]"
    end
  end
end
