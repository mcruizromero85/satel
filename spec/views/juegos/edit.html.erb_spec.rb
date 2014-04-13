require 'spec_helper'

describe "juegos/edit" do
  before(:each) do
    @juego = assign(:juego, stub_model(Juego,
      :nombre => "MyString",
      :descripcion => "MyString",
      :asociado_id => 1
    ))
  end

  it "renders the edit juego form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", juego_path(@juego), "post" do
      assert_select "input#juego_nombre[name=?]", "juego[nombre]"
      assert_select "input#juego_descripcion[name=?]", "juego[descripcion]"
      assert_select "input#juego_asociado_id[name=?]", "juego[asociado_id]"
    end
  end
end
