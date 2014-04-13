require 'spec_helper'

describe "asociados/edit" do
  before(:each) do
    @asociado = assign(:asociado, stub_model(Asociado,
      :nombre => "MyString",
      :descripcion => "MyString",
      :juego_id => 1
    ))
  end

  it "renders the edit asociado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asociado_path(@asociado), "post" do
      assert_select "input#asociado_nombre[name=?]", "asociado[nombre]"
      assert_select "input#asociado_descripcion[name=?]", "asociado[descripcion]"
      assert_select "input#asociado_juego_id[name=?]", "asociado[juego_id]"
    end
  end
end
