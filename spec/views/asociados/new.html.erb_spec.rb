require 'spec_helper'

describe "asociados/new" do
  before(:each) do
    assign(:asociado, stub_model(Asociado,
      :nombre => "MyString",
      :descripcion => "MyString",
      :juego_id => 1
    ).as_new_record)
  end

  it "renders new asociado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asociados_path, "post" do
      assert_select "input#asociado_nombre[name=?]", "asociado[nombre]"
      assert_select "input#asociado_descripcion[name=?]", "asociado[descripcion]"
      assert_select "input#asociado_juego_id[name=?]", "asociado[juego_id]"
    end
  end
end
